using Library.Contracts.Errors;

namespace Library.Contracts.Exceptions;

public class CustomValidationException : Exception
{
    public List<ValidationError> ValidationErros { get; set; }
    
    public CustomValidationException(List<ValidationError> validationErrors)
    {
        ValidationErros = validationErrors;
    }
}