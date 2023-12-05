using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System;
using ContosoUniversity.WebApplication;
using ContosoUniversity.WebApplication.Models;
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
    builder.Services.AddApplicationInsightsTelemetry(builder.Configuration["APPLICATIONINSIGHTS_CONNECTION_STRING"]);
}
else
{
  builder.Services.AddApplicationInsightsTelemetry();
}

// Adding Health checks
builder.Services.AddHealthChecks().AddCheck<WebAppHealthCheck>("Custom Health");

// Adding a check of the WebAPI health, to display dependent pages/links/actions or not
builder.Services.AddHostedService<CheckWebApiHealthHostedService>();

#endregion

#region   ===============   BUILDING THEN RUN THE APP  ===============
var app = builder.Build();

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
// It will be updated by the CheckWebApiHealthHostedService (that checks every 5 seconds)
Config.App["WebApiIsAccessible"] = "false";

app.Run();
#endregion
