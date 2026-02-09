using System.ComponentModel.DataAnnotations;

namespace repository.ViewModel;

public class FormViewModel
{
  public int? Id { get; set; }

  [Required(ErrorMessage = "Name is required")]
  [MaxLength(50, ErrorMessage = "Fist Name should be less then 50 character")]
  [RegularExpression(@"^[a-zA-Z0-9]+$", ErrorMessage = "First Name can only contain letters.")]

  //   [RegularExpression(@"^[A-Za-z0-9]+(?:\s[A-Za-z0-9]+)*$", ErrorMessage = "Invalid name.")]  (for allow space between words)
  // [MaxLength(50)]
  public string Name { get; set; } = null!;

  [Required(ErrorMessage = "Email is required")]
  [MaxLength(50, ErrorMessage = "Email should be less then 50 character")]
  [RegularExpression(@"^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$", ErrorMessage = "Invalid Email")]
  [EmailAddress(ErrorMessage = "Invalid email format.")]
  public int Email { get; set; }

  [Required(ErrorMessage = "DOB is required")]
  public string DOB { get; set; }

  [Required(ErrorMessage = "Category is required")]
  public string Category { get; set; } = null!;

  public bool IsAvailable { get; set; }

  [Required(ErrorMessage = "Phone is required")]
  [RegularExpression(@"^[1-9]\d{9}$", ErrorMessage = "Please enter a valid phone number.")]
  [MaxLength(10)]
  public string? Phone { get; set; }

  [Required(ErrorMessage = "Amount is required")]
  [Range(1, 99999999.99, ErrorMessage = "Rate should be between 1 - 99999999.99")]
  [RegularExpression(@"^\d+(\.\d{1,2})?$", ErrorMessage = "Rate should be in 12.12 form")]
  public decimal Amount { get; set; }
  public string? Gender { get; set; }
}
