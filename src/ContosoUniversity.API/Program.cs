using Azure.Identity;
using System;
using ContosoUniversity.API.Data;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;

#region Application Builder
var builder = WebApplication.CreateBuilder(args);

// ReSharper disable once RedundantAssignment
var connectionString = string.Empty;
if (builder.Configuration["AZURE_KEY_VAULT_ENDPOINT"] != null)
{
    var credential = new DefaultAzureCredential();
    builder.Configuration.AddAzureKeyVault(new Uri(builder.Configuration["AZURE_KEY_VAULT_ENDPOINT"]), credential);
    connectionString = builder.Configuration[builder.Configuration["AZURE_SQL_CONNECTION_STRING_KEY"]];
}
else
{
    connectionString = builder.Configuration.GetConnectionString("ContosoUniversityAPIContext");
}

builder.Services.AddDbContext<ContosoUniversityAPIContext>(options =>
{
    options.UseSqlServer(connectionString, sqlOptions => sqlOptions.EnableRetryOnFailure());
});

builder.Services.AddControllers();

builder.Services.AddApplicationInsightsTelemetry(builder.Configuration);

builder.Services.AddHealthChecks();

var app = builder.Build();
#endregion

#region Application Middlewares and Run
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
    await using var scope = app.Services.CreateAsyncScope();
    var db = scope.ServiceProvider.GetRequiredService<ContosoUniversityAPIContext>();
    await DbInitializer.Initialize(db);
}
else
{
    app.UseExceptionHandler("/Error");

    // The default HSTS value is 30 days.
    // You may want to change this for production scenarios,
    // see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseRouting();

app.UseAuthorization();

app.UseEndpoints(endpoints =>
{
    endpoints.MapControllers();
});

app.UseHealthChecks("/healthz");

// Register the Swagger generator and the Swagger UI middleware
app.UseOpenApi();
app.UseSwaggerUi3();

app.Run();
#endregion
