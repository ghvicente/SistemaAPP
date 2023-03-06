using SistemaAPP.Domain.Products;
using SistemaAPP.Infra.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace SistemaAPP.Endpoints.Categories
{
    public class CategoryDelete
    {
        public static string Template => "/categories/{id}";

        public static string[] Methods => new string[] { HttpMethod.Delete.ToString() };

        public static Delegate Handle => Action;

        [Authorize(Policy = "EmployeePolicy")]
        public static IResult Action([FromRoute] Guid id,  ApplicationDbContext context)
        {
            var category = context.Categories.Where(f => f.Id == id).FirstOrDefault();
            context.Remove(category);
            context.SaveChanges();

            return Results.Ok();
        }
    }
}
