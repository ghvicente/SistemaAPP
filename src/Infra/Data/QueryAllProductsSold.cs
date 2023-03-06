using Dapper;
using SistemaAPP.Endpoints.Products;
using Microsoft.Data.SqlClient;

namespace SistemaAPP.Infra.Data
{
    public class QueryAllProductsSold
    {
        private readonly IConfiguration configuration;

        public QueryAllProductsSold(IConfiguration configuration)
        {
            this.configuration = configuration;
        }

        public async Task<IEnumerable<ProductSoldResponse>> Execute()
        {
            var db = new SqlConnection(configuration["ConnectionString:SistemaAPPDb"]);
            var query =
                @"select p.Id, p.Name, count(*) amount
                from Orders o inner join OrderProducts op on o.Id = op.OrdersId
	                          inner join Products p on p.Id = op.ProductsId
                group by
	                p.Id, p.Name
                order by amount desc";
                
            return await db.QueryAsync<ProductSoldResponse>(query);
        }
    }
}
