using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Validations;
using System.IdentityModel.Tokens.Jwt;
using System.Runtime.CompilerServices;
using System.Security.Claims;
using System.Text;

namespace SistemaAPP.Endpoints.Security
{
    public class TokenPost
    {
        //criando a propriedade "template" e define a rota que ele vai utilizar para acesso.
        public static string Template => "/token";

        public static string[] Methods => new string[] { HttpMethod.Post.ToString() };

        public static Delegate Handle => Action;

        [AllowAnonymous]
        public static IResult Action(LoginRequest loginRequest, IConfiguration configuration, UserManager<IdentityUser> userManager, ILogger<TokenPost> log, IWebHostEnvironment environment)
        {
            log.LogInformation("Getting token.");
            var user = userManager.FindByEmailAsync(loginRequest.Email).Result;
            if (user == null)
                return Results.BadRequest();

            if (!userManager.CheckPasswordAsync(user, loginRequest.Password).Result)
                return Results.BadRequest();

            var claims = userManager.GetClaimsAsync(user).Result;  
            var subject = new ClaimsIdentity(new Claim[]
            {
                new Claim(ClaimTypes.Email, loginRequest.Email),   
                new Claim(ClaimTypes.NameIdentifier, user.Id),     

            });
            subject.AddClaims(claims);   

            //Gerar o TOKEN
            var key = Encoding.ASCII.GetBytes(configuration["JwtBearerTokenSettings:SecretKey"]);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = subject,
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature),
                Audience = configuration["JwtBearerTokenSettings:Audience"],
                Issuer = configuration["JwtBearerTokenSettings:Issuer"],
                Expires = environment.IsDevelopment() || environment.IsStaging() ? DateTime.UtcNow.AddYears(1) : DateTime.UtcNow.AddMinutes(60)  //Case seja ambiente de DEV ou STAGE token vale por 1 ano, se for Produção vale apenas 60 minutos
            };

            var tokenHandler = new JwtSecurityTokenHandler();
            var token = tokenHandler.CreateToken(tokenDescriptor);

            return Results.Ok(new
            {
                token = tokenHandler.WriteToken(token)
            });
        }
    }
}
