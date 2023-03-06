using SistemaAPP.Infra.Data;
using Microsoft.AspNetCore.Authorization;


namespace SistemaAPP.Endpoints.Employees
{
    public class EmployeeGetAll
    {
        public static string Template => "/employees";

        public static string[] Methods => new string[] { HttpMethod.Get.ToString() };

        public static Delegate Handle => Action;


        [Authorize(Policy = "EmployeePolicy")]  
        public static async Task<IResult> Action(QueryAllUserWitchClaimEmployeeCode query)
        {
            var result = await query.Execute();
            return Results.Ok(result);
        }

    }
}
