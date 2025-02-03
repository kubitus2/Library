using System.Reflection;
using FluentValidation;
using Library.Application.Behaviours;
using Library.Application.Mappings;
using Library.Domain.Repositories;
using Library.Infrastructure;
using Library.Infrastructure.Repositories;
using Microsoft.Extensions.DependencyInjection;

namespace Library.Application;

public static class DependencyInjection
{
    public static IServiceCollection AddApplication(this IServiceCollection services)
    {
        services.AddMediatR(config =>
        {
            config.RegisterServicesFromAssembly(Assembly.GetExecutingAssembly());
            config.AddOpenBehavior(typeof(ValidationBehaviour<,>));
        });

        services.AddAutoMapper(Assembly.GetExecutingAssembly());
        services.AddValidatorsFromAssembly(Assembly.GetExecutingAssembly());
        services.AddScoped<IUnitOfWork>(sp => sp.GetRequiredService<LibraryDbContext>());
        services.AddScoped<IUserRepository, UserRepository>();
        
        return services;
    }
}