using System;
using System.Collections.Generic;

namespace Library.Infrastructure;

public partial class FeeType
{
    public int Id { get; set; }

    public string Type { get; set; } = null!;

    public virtual ICollection<Fee> Fees { get; set; } = new List<Fee>();
}