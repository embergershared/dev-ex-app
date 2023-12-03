using System.Threading;
using System.Threading.Tasks;
using ContosoUniversity.WebApplication.Models;
using Microsoft.Extensions.Diagnostics.HealthChecks;

namespace ContosoUniversity.WebApplication
{
    public class WebAppHealthCheck : IHealthCheck
    {
        public Task<HealthCheckResult> CheckHealthAsync(HealthCheckContext context, CancellationToken cancellationToken = default)
        {
            // One option is to set the app as degraded if the WebApi is not accessible.
            //return Task.FromResult(bool.Parse(Config.App["WebApiIsAccessible"]) ? 
            //    HealthCheckResult.Healthy() : HealthCheckResult.Degraded());

            // Or just set it as healthy because it is running.
            return Task.FromResult(HealthCheckResult.Healthy("The Contoso University Web APP is healthy."));
        }
    }
}
