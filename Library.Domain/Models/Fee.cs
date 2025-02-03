using System;
using System.Collections.Generic;
using Library.Domain.Models;

namespace Library.Models;

public partial class Fee
{
    public int Id { get; set; }

    public decimal? Amount { get; set; }

    public int CheckoutId { get; set; }

    public int FeeType { get; set; }

    public int UserId { get; set; }

    public string? Description { get; set; }
    public bool Paid { get; set; }

    public virtual Checkout Checkout { get; set; } = null!;

    public virtual FeeType FeeTypeNavigation { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}