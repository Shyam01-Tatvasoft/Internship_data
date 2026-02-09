using System.ComponentModel.DataAnnotations;

namespace Repository.ViewModels;

public class RegisterViewModel
{
    [Required(ErrorMessage = "Name is required.")]
    [MaxLength(50, ErrorMessage = "Name should be less then 50 character")]
    [RegularExpression(@"^[A-Za-z0-9]+(?:\s[A-Za-z0-9]+)*$", ErrorMessage = "Invalid name.")]
    public string Name { get; set; } = null!;

    [Required(ErrorMessage = "Email is required.")]
    [MaxLength(50, ErrorMessage = "Email should be less then 50 character")]
    [RegularExpression(@"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$", ErrorMessage = "Invalid Email")]
    public string Email { get; set; } = null!;

    [Required(ErrorMessage = "Password is required"), DataType(DataType.Password), MinLength(8)]
    [MaxLength(200, ErrorMessage = "Password should be less then 200 character")]
    [RegularExpression(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&]).{8,}$",
                ErrorMessage = "Password must be at least 8 characters long and include uppercase, lowercase, number and special character.")]
    public string Password { get; set; } = null!;

    [Required(ErrorMessage = "Phone is required")]
    [RegularExpression(@"^[1-9]\d{9}$", ErrorMessage = "Please enter a valid phone number.")]
    [MaxLength(10)]
    public string? Phone { get; set; }
}
