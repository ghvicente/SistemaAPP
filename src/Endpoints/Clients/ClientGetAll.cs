using Microsoft.AspNetCore.Authorization;
using SistemaAPP.Infra.Data;

namespace SistemaAPP.Endpoints.Clients
{
    public class ClientGetAll
    {
        
        public static string Template => "/clients/all";

        
        public static string[] Methods => new string[] { HttpMethod.Get.ToString() };

        
        public static Delegate Handle => Action;


        [Authorize(Policy = "EmployeePolicy")]  
        
        public static async Task<IResult> Action(QueryAllUserWitchClaimCpf query)
        {
            var result = await query.Execute();
            return Results.Ok(result);
        }
    }
}
