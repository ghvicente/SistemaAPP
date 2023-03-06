using Dapper;
using Microsoft.Data.SqlClient;
using SistemaAPP.Endpoints.Employees;

namespace SistemaAPP.Infra.Data
{
    public class QueryAllUserWitchClaimEmployeeCode
    {
        private readonly IConfiguration configuration;

        public QueryAllUserWitchClaimEmployeeCode(IConfiguration configuration)
        {
            this.configuration = configuration;
        }

        public async Task<IEnumerable<EmployeeResponse>> Execute()
        {
            var db = new SqlConnection(configuration["ConnectionString:SistemaAPPDb"]);
            var query =
                @"select Email, ClaimValue as Name
                from AspNetUsers u inner join AspNetUserClaims c
                           on u.id = c.UserId and claimtype = 'EmployeeCode'
                order by name";
                

            return await db.QueryAsync<EmployeeResponse>(query);
        }
    }
}
