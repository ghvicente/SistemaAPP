using SistemaAPP.Endpoints.Categories;
using SistemaAPP.Infra.Data;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace SistemaAPP.Endpoints.Products
{
    public class ProductPut
    {
        public static string Template => "/products/{id:guid}"; 

        public static string[] Methods => new string[] { HttpMethod.Put.ToString() };

        public static Delegate Handle => Action;

        [Authorize(Policy = "EmployeePolicy")]
        public static async Task<IResult> Action([FromRoute] Guid id, ProductRequest productRequest, HttpContext http, ApplicationDbContext context)
        {
            var userId = http.User.Claims.First(c => c.Type == ClaimTypes.NameIdentifier).Value;

            var category = await context.Categories.FirstOrDefaultAsync(c => c.Id == productRequest.CategoryId);
            if (category == null)
                return Results.NotFound();

            var product = await context.Products.FirstOrDefaultAsync(p => p.Id == id);
            if (product == null)
                return Results.NotFound();


            product.EditInfo(productRequest.Name, category,  productRequest.Description,  productRequest.HasStock, productRequest.Price, productRequest.Active, userId);

            if (!product.IsValid)
                return Results.ValidationProblem(product.Notifications.ConvertToProblemDetails());

            await context.SaveChangesAsync();

            return Results.Ok();
        }
    }
}
