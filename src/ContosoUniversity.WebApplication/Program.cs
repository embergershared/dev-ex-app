using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System;
using ContosoUniversity.WebApplication;
using ContosoUniversity.WebApplication.Models;

#region Application Builder
var builder = WebApplication.CreateBuilder(args);

builder.Services.Configure<CookiePolicyOptions>(options =>
{
  // This lambda determines whether user consent for non-essential cookies is needed for a given request.
  options.CheckConsentNeeded = _ => true;
  options.MinimumSameSitePolicy = SameSiteMode.None;
});

// If the WebAPI is set by an "URLAPI" env variable value, (as in a docker container)
if (builder.Configuration["URLAPI"] != null)
{
  builder.Services.AddHttpClient("client", client => { client.BaseAddress = new Uri(builder.Configuration["URLAPI"]); });
}
else
{
  // Else, use normal appsettings / App Service configuration
  var section = builder.Configuration.GetSection("Api");
  builder.Services.AddHttpClient("client", client => { client.BaseAddress = new Uri(section["Address"]); });
}

builder.Services.AddRazorPages();
if (builder.Configuration["APPLICATIONINSIGHTS_CONNECTION_STRING"] != null)
{
  builder.Services.AddApplicationInsightsTelemetry(options =>
  {
    options.ConnectionString = builder.Configuration["APPLICATIONINSIGHTS_CONNECTION_STRING"];
  });
}
else
{
  builder.Services.AddApplicationInsightsTelemetry();
}

// Adding Health checks
builder.Services.AddHealthChecks()
    .AddCheck<WebAppHealthCheck>("Custom Health");

//builder.Services.AddHostedService<CheckWebApiHealthHostedService>();

var app = builder.Build();
#endregion

#region Application Middlewares and Run
if (app.Environment.IsDevelopment())
{
  app.UseDeveloperExceptionPage();
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

app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.UseEndpoints(endpoints =>
{
  endpoints.MapRazorPages();
});

app.UseHealthChecks("/healthz");

// Initialize the WebAPI health status.
// It will be updated by the CheckWebApiHealth service
Config.App["WebApiIsAccessible"] = "true";

app.Run();
#endregion
