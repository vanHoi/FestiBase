﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Organisation
/// </summary>
public class Organisation
{
    private int organisationNumber;
    private int name;

    public Organisation(int organisationNumber, int name)
    {
        this.organisationNumber = organisationNumber;
        this.name = name;
    }
}