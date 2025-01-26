using Library.Contracts.Exceptions;
using Microsoft.AspNetCore.Diagnostics;
using Microsoft.AspNetCore.Mvc;

namespace Library.Presentation.Handlers;

public class ExceptionHandler : IExceptionHandler
{
    public async ValueTask<bool> TryHandleAsync(HttpContext httpContext, Exception exception,
        CancellationToken cancellationToken)
    {
        var problemDetails = CreateProblemDetails(exception);
        httpContext.Response.StatusCode = problemDetails.Status ?? StatusCodes.Status500InternalServerError;
        return false;
    }

    private static ProblemDetails CreateProblemDetails(Exception exception)
    {
        var problemDetails = exception switch
        {
            NotFoundException => CreateProblemDetails(StatusCodes.Status404NotFound,
                "Not Found", exception.Message),
            CustomValidationException => CreateProblemDetails(StatusCodes.Status400BadRequest,
                "Validation error", "One or more validation errors occured"),
            _ => CreateProblemDetails(StatusCodes.Status500InternalServerError,
                "Internal Server Error", "An unexpected error occured")
        };

        if (exception is CustomValidationException validationException)
        {
            problemDetails.Extensions["errors"] = validationException.ValidationErros;
        }

        return problemDetails;
    }

    private static ProblemDetails CreateProblemDetails(int status, string title, string detail)
    {
        return new ProblemDetails
        {
            Status = status,
            Title = title,
            Detail = detail,
        };
    }
}