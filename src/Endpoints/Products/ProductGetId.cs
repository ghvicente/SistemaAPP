using SistemaAPP.Infra.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace SistemaAPP.Endpoints.Products
{
    public class ProductGetId
    {

        public static string Template => "/products/{id}";
        public static string[] Methods => new string[] { HttpMethod.Get.ToString() };
        public static Delegate Handle => Action;

        [Authorize(Policy = "EmployeePolicy")]
        public static async Task<IResult> Action([FromRoute] Guid id,ApplicationDbContext context)
        {
            var products = context.Products.Include(p => p.Category).Where(p => p.Id == id).OrderBy(p => p.Name).ToList();
            var results = products.Select(p => new ProductResponse(p.Id, p.Name, p.Category.Name, p.Description, p.HasStock, p.Price, p.Active));
            if (results != null)
            {
                return Results.Ok(results);
            }
            return Results.NotFound();
        }
    }
}
