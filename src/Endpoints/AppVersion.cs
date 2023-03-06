using SistemaAPP.Endpoints.Categories;
using SistemaAPP.Infra.Data;
using Microsoft.AspNetCore.Authorization;

namespace SistemaAPP.Endpoints
{
    
    public class AppVersion
    {
        public static string Template => "/version";

        public static string[] Methods => new string[] { HttpMethod.Get.ToString() };

        public static Delegate Handle => Action;

        [AllowAnonymous]
        public static IResult Action(IConfiguration configuration)
        {
            return Results.Ok($"{configuration["Application:Name"]} - {configuration["Application:Version"]}");


        }
    }
}
