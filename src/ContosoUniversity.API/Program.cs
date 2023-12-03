using Azure.Identity;
using System;
using ContosoUniversity.API.Data;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

#region Program.cs specific logger instance
var logger = LoggerFactory
    .Create(builder => builder
        // add console as logging target
        .AddConsole()
        // add debug output as logging target
        .AddDebug()
        // set minimum level to Trace
        .SetMinimumLevel(LogLevel.Trace))
    .CreateLogger<Program>();

logger.LogInformation("Program.cs: Logger<Program> created");
#endregion

#region   ===============   CREATING THE APP BUILDER   ===============
logger.LogInformation("Program.cs: Invoking WebApplication.CreateBuilder(args)");
var builder = WebApplication.CreateBuilder(args);

// ReSharper disable once RedundantAssignment
var connectionString = string.Empty;
if (builder.Configuration["AZURE_KEY_VAULT_ENDPOINT"] != null)
{
    logger.LogInformation("Connecting to SQL Database with AZURE_KEY_VAULT_ENDPOINT & AZURE_SQL_CONNECTION_STRING_KEY");

    // Get SQL Connection string from Key vault. Wired to be used on Azure App service.
    var credential = new DefaultAzureCredential();
  builder.Configuration.AddAzureKeyVault(new Uri(builder.Configuration["AZURE_KEY_VAULT_ENDPOINT"]), credential);
  connectionString = builder.Configuration[builder.Configuration["AZURE_SQL_CONNECTION_STRING_KEY"]];
}
else
{
    logger.LogInformation("Connecting to SQL Database with ContosoUniversityAPIContext");

    // If the settings we expect from the App service are not here, use a ConnectionString.
    connectionString = builder.Configuration.GetConnectionString("ContosoUniversityAPIContext");
}

builder.Services.AddDbContext<ContosoUniversityAPIContext>(options =>
{
  options.UseSqlServer(connectionString, sqlOptions => sqlOptions.EnableRetryOnFailure());
});

builder.Services.AddControllers();

builder.Services.AddApplicationInsightsTelemetry(builder.Configuration);

builder.Services.AddHealthChecks();

// Swashbuckle Swagger
builder.Services.AddSwaggerGen();
#endregion

#region   ===============   BUILDING THEN RUN THE APP  ===============
var app = builder.Build();

if (app.Environment.IsDevelopment())
{
  app.UseDeveloperExceptionPage();

  // Swashbuckle Swagger
  app.UseSwagger();   // https://localhost:58372/swagger/v1/swagger.json
  app.UseSwaggerUI(); // https://localhost:58372/swagger

  // Seed database
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

app.Run();
#endregion
