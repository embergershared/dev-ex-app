using ContosoUniversity.WebApplication.Models;
using Microsoft.Extensions.Hosting;
using System.Net.Http;
using System.Threading.Tasks;
using System.Threading;
using System;

namespace ContosoUniversity.WebApplication
{
    public class CheckWebApiHealthHostedService : IHostedService, IDisposable
    {
        private Timer _timer;
        private readonly IHttpClientFactory _httpClientFactory;

        public CheckWebApiHealthHostedService(IHttpClientFactory httpClientFactory)
        {
            _httpClientFactory = httpClientFactory;
        }

        public Task StartAsync(CancellationToken cancellationToken)
        {
            _timer = new Timer(DoWork, null, TimeSpan.Zero, TimeSpan.FromSeconds(5));
            return Task.CompletedTask;
        }

        private void DoWork(object state)
        {
            var client = _httpClientFactory.CreateClient("client");
            try
            {
                _ = client.GetStringAsync("/healthz").Result;
                Config.App["WebApiIsAccessible"] = "true";
            }
            catch (Exception)
            {
                Config.App["WebApiIsAccessible"] = "false";
            }
        }

        public Task StopAsync(CancellationToken cancellationToken)
        {
            _timer?.Change(Timeout.Infinite, 0);
            return Task.CompletedTask;
        }

        public void Dispose()
        {
            _timer?.Dispose();
        }
    }

}
