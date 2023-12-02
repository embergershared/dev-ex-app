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
            return Task.FromResult(bool.Parse(Config.App["WebApiIsAccessible"]) ? 
                HealthCheckResult.Healthy() : HealthCheckResult.Degraded());
        }
    }
}
