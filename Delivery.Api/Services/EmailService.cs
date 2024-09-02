using Delivery.Api.CU;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using System.Net;
using System.Net.Mail;

namespace Delivery.Api.Services
{
    public class EmailService
    {
        private readonly SmtpClient _smtpClient;
        private readonly SmtpSettings _smtpSettings;

        public EmailService(IOptions<SmtpSettings> smtpSettings)
        {


            _smtpSettings = smtpSettings.Value;
            _smtpClient = new SmtpClient(_smtpSettings.Server)
            {

                Port = _smtpSettings.Port,
                Credentials = new NetworkCredential(_smtpSettings.Username, _smtpSettings.Password),
                EnableSsl = true
            };
        }

        public async Task SendEmailAsync(string recipient, string subject, string body)
        {
            var mailMessage = new MailMessage
            {
                From = new MailAddress(_smtpSettings.Username),
                Subject = subject,
                Body = body,
                IsBodyHtml = true 
            };

            mailMessage.To.Add(recipient);

            try
            {
                await _smtpClient.SendMailAsync(mailMessage);
                Console.WriteLine($"Email sent to {recipient}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Failed to send email to {recipient}: {ex.Message}");
            }
        }
    }
}
