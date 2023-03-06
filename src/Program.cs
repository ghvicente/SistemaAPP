using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Diagnostics;
using Microsoft.AspNetCore.Identity;
using Microsoft.Data.SqlClient;
using Microsoft.IdentityModel.Tokens;
using Serilog;
using Serilog.Sinks.MSSqlServer;
using SistemaAPP.Domain.Users;
using SistemaAPP.Endpoints;
using SistemaAPP.Endpoints.Categories;
using SistemaAPP.Endpoints.Clients;
using SistemaAPP.Endpoints.Employees;
using SistemaAPP.Endpoints.Orders;
using SistemaAPP.Endpoints.Products;
using SistemaAPP.Endpoints.Security;
using SistemaAPP.Infra.Data;
using System.Text;

var builder = WebApplication.CreateBuilder(args);


builder.WebHost.UseSerilog((context, configuration) => {
    configuration
        .WriteTo.Console()
        .WriteTo.MSSqlServer(
            context.Configuration["ConnectionString:SistemaAPPDb"],
                sinkOptions: new MSSqlServerSinkOptions()
                {
                    AutoCreateSqlTable = true,
                    TableName = "LogAPI"
                });
});


builder.Services.AddSqlServer<ApplicationDbContext>(builder.Configuration["ConnectionString:SistemaAPPDb"]);


builder.Services.AddIdentity<IdentityUser, IdentityRole>(options =>
{
    options.Password.RequireNonAlphanumeric = false;    
    options.Password.RequireDigit = false;              
    options.Password.RequireUppercase = false;          
    options.Password.RequiredLength = 3;                
    options.Password.RequireLowercase = false;          
}).AddEntityFrameworkStores<ApplicationDbContext>();  

builder.Services.AddAuthorization(options =>
{
    options.FallbackPolicy = new AuthorizationPolicyBuilder()
      .AddAuthenticationSchemes(JwtBearerDefaults.AuthenticationScheme)
      .RequireAuthenticatedUser()
      .Build();

    options.AddPolicy("EmployeePolicy", p =>
        p.RequireAuthenticatedUser().RequireClaim("EmployeeCode"));    


    options.AddPolicy("CpfPolicy", p =>
    p.RequireAuthenticatedUser().RequireClaim("Cpf"));    

});



builder.Services.AddAuthentication(x =>
{
    x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;   
    x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme; 
}).AddJwtBearer(options =>             
{
    options.TokenValidationParameters = new TokenValidationParameters()    
    { 
        ValidateActor = true,                               
        ValidateIssuer = true,
        ValidateAudience = true,                            
        ValidateLifetime = true,                            
        ValidateIssuerSigningKey = true,                    
        ClockSkew = TimeSpan.Zero,
        ValidIssuer = builder.Configuration["JwtBearerTokenSettings:Issuer"],     
        ValidAudience = builder.Configuration["JwtBearerTokenSettings:Audience"],   
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["JwtBearerTokenSettings:SecretKey"]))  
    };

})  ;



builder.Services.AddScoped<QueryAllUserWitchClaimEmployeeCode>();
builder.Services.AddScoped<QueryAllUserWitchClaimCpf>();
builder.Services.AddScoped<QueryAllUsersWithClaimName>(); 
builder.Services.AddScoped<QueryAllProductsSold>();
builder.Services.AddScoped<UserCreator>(); 


builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();




//Category
app.MapMethods(CategoryPost.Template, CategoryPost.Methods, CategoryPost.Handle);
app.MapMethods(CategoryGetAll.Template, CategoryGetAll.Methods, CategoryGetAll.Handle);
app.MapMethods(CategoryPut.Template, CategoryPut.Methods, CategoryPut.Handle);
app.MapMethods(CategoryDelete.Template, CategoryDelete.Methods, CategoryDelete.Handle);
//Employee (Usuários do Identity)
app.MapMethods(EmployeePost.Template, EmployeePost.Methods, EmployeePost.Handle);
app.MapMethods(EmployeeGetAll.Template, EmployeeGetAll.Methods, EmployeeGetAll.Handle);
//Products
app.MapMethods(ProductGetAll.Template, ProductGetAll.Methods, ProductGetAll.Handle);
app.MapMethods(ProductGetShowcase.Template, ProductGetShowcase.Methods, ProductGetShowcase.Handle);
app.MapMethods(ProductSoldGet.Template, ProductSoldGet.Methods, ProductSoldGet.Handle);
app.MapMethods(ProductPost.Template, ProductPost.Methods, ProductPost.Handle);
app.MapMethods(ProductPut.Template, ProductPut.Methods, ProductPut.Handle);
app.MapMethods(ProductGetId.Template, ProductGetId.Methods, ProductGetId.Handle);
//Clients
app.MapMethods(ClientGetAll.Template, ClientGetAll.Methods, ClientGetAll.Handle);
app.MapMethods(ClientPost.Template, ClientPost.Methods, ClientPost.Handle);
app.MapMethods(ClientGet.Template, ClientGet.Methods, ClientGet.Handle);
//Orders 
app.MapMethods(OrderPost.Template, OrderPost.Methods, OrderPost.Handle);
app.MapMethods(OrderGet.Template, OrderGet.Methods, OrderGet.Handle);
//Security
app.MapMethods(TokenPost.Template, TokenPost.Methods, TokenPost.Handle);


app.MapMethods(AppVersion.Template, AppVersion.Methods, AppVersion.Handle);

app.UseExceptionHandler("/error");  
app.Map("/error", (HttpContext http) =>
{
    var error = http.Features?.Get<IExceptionHandlerFeature>()?.Error;
    if (error != null)
    {
        if (error is AggregateException)
            return Results.Problem(title: $"Database out. {error.GetBaseException().Message}", statusCode: 500);
        else if (error is SqlException)
            return Results.Problem(title: $"Database error. {error.GetBaseException().Message}", statusCode: 500);
        else if (error is BadHttpRequestException)
            return Results.Problem(title: $"Error to convert data to other type. See all the information sent. {error.GetBaseException().Message}", statusCode: 500);
    }

    return Results.Problem(title: $"An error ocurred. {error.GetBaseException().Message}", statusCode: 500);
});

app.Run();

