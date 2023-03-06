using Dapper;
using SistemaAPP.Endpoints.Clients;
using Microsoft.Data.SqlClient;

namespace SistemaAPP.Infra.Data
{
    public class QueryAllUserWitchClaimCpf
    {
        private readonly IConfiguration configuration;

        public QueryAllUserWitchClaimCpf(IConfiguration configuration)
        {
            this.configuration = configuration;
        }

        public async Task<IEnumerable<ClientResponse>> Execute()
        {
            var db = new SqlConnection(configuration["ConnectionString:SistemaAPPDb"]);
            var query =
                @"select Email,  c.ClaimValue as Name, d.ClaimValue as Cpf
                from AspNetUsers u inner join AspNetUserClaims c
                           on u.id = c.UserId and c.claimtype = 'Name'
						   inner join AspNetUserClaims d
						   on u.id = d.UserId and d.ClaimType = 'Cpf'
                order by name";


            return await db.QueryAsync<ClientResponse>(query);
        }
    }
}
