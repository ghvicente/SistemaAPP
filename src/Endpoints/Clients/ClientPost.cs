using SistemaAPP.Domain.Products;
using SistemaAPP.Domain.Users;
using SistemaAPP.Endpoints.Employees;
using SistemaAPP.Infra.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using System.Security.Claims;

namespace SistemaAPP.Endpoints.Clients
{
    public class ClientPost
    {

        public static string Template => "/clients";

        public static string[] Methods => new string[] { HttpMethod.Post.ToString() };

        public static Delegate Handle => Action;

        [AllowAnonymous]
        public static async Task<IResult> Action(ClientRequest clientRequest, UserCreator userCreator)
        {
            var clientClaims = new List<Claim>
            {
                new Claim("Cpf", clientRequest.Cpf),
                new Claim("Name", clientRequest.Name),
            };
            (IdentityResult identity, string userID) result = await userCreator.Create(clientRequest.Email, clientRequest.Password, clientClaims);
            if (!result.identity.Succeeded)
            {
                return Results.ValidationProblem(result.identity.Errors.ConvertToProblemDetails());
            }

            return Results.Created($"/clients/{result.userID}", result.userID);
        }
    }
}
