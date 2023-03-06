using SistemaAPP.Domain.Products;
using SistemaAPP.Domain.Users;
using SistemaAPP.Endpoints.Clients;
using SistemaAPP.Infra.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using System.Security.Claims;

namespace SistemaAPP.Endpoints.Employees
{
    public class EmployeePost
    {
        public static string Template => "/employees";
        public static string[] Methods => new string[] { HttpMethod.Post.ToString() };
        public static Delegate Handle => Action;
        [Authorize(Policy = "EmployeePolicy")]
        public static async Task<IResult> Action(EmployeeRequest employeeRequest, HttpContext http, UserCreator userCreator )
        {
            var userId = http.User.Claims.First(c => c.Type == ClaimTypes.NameIdentifier).Value;  

            var userClaims = new List<Claim>
            {
                new Claim("EmployeeCode", employeeRequest.EmployeeCode),
                new Claim("Name", employeeRequest.Name),
                new Claim("CreatedBy", userId),
            };


            (IdentityResult identity, string userID) result = await userCreator.Create(employeeRequest.Email, employeeRequest.Password, userClaims);
            if (!result.identity.Succeeded)
            {
                return Results.ValidationProblem(result.identity.Errors.ConvertToProblemDetails());
            }

            return Results.Created($"/employees{result.userID}", result.userID);
        }
    }
}
