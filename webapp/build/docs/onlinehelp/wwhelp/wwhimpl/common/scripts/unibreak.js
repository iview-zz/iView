// Copyright (c) 2009-2010 Quadralay Corporation.  All rights reserved.
//

function WWHUnicode_Break_CheckBreak_Sequence(ParamPrevious,
                                              ParamCurrent)
{
  var  VarResult = true;

  if (
      (
       (ParamPrevious == " ")
      )
       &&
      (
       (true)
      )
     )
  {
    VarResult = false;
  }
  else if (
           (
            (true)
           )
            &&
           (
            (WWHUnicodeInfo_WWNoBreak(ParamCurrent))
           )
          )
  {
    VarResult = false;
  }
  else if (
           (
            (WWHUnicodeInfo_WWNoBreak(ParamPrevious))
           )
            &&
           (
            (true)
           )
          )
  {
    VarResult = false;
  }
  else if (
           (
            (WWHUnicodeInfo_Korean_L(ParamPrevious))
           )
            &&
           (
            (WWHUnicodeInfo_Korean_L(ParamCurrent))
           )
          )
  {
    VarResult = false;
  }
  else if (
           (
            (WWHUnicodeInfo_Korean_L(ParamPrevious))
             ||
            (WWHUnicodeInfo_Korean_LV(ParamPrevious))
           )
            &&
           (
            (WWHUnicodeInfo_Korean_LV(ParamCurrent))
           )
          )
  {
    VarResult = false;
  }
  else if (
           (
            (WWHUnicodeInfo_Korean_L(ParamPrevious))
             ||
            (WWHUnicodeInfo_Korean_LV(ParamPrevious))
           )
            &&
           (
            (WWHUnicodeInfo_Korean_V(ParamCurrent))
           )
          )
  {
    VarResult = false;
  }
  else if (
           (
            (WWHUnicodeInfo_Korean_L(ParamPrevious))
           )
            &&
           (
            (WWHUnicodeInfo_Korean_LVT(ParamCurrent))
           )
          )
  {
    VarResult = false;
  }
  else if (
           (
            (WWHUnicodeInfo_Korean_L(ParamPrevious))
             ||
            (WWHUnicodeInfo_Korean_LV(ParamPrevious))
             ||
            (WWHUnicodeInfo_Korean_V(ParamPrevious))
             ||
            (WWHUnicodeInfo_Korean_LVT(ParamPrevious))
             ||
            (WWHUnicodeInfo_Korean_T(ParamPrevious))
           )
            &&
           (
            (WWHUnicodeInfo_Korean_T(ParamCurrent))
           )
          )
  {
    VarResult = false;
  }
  else if (
           (
            (WWHUnicodeInfo_ALetter(ParamPrevious))
             ||
            (WWHUnicodeInfo_ABaseLetter(ParamPrevious))
             ||
            (WWHUnicodeInfo_ACMLetter(ParamPrevious))
             ||
            (WWHUnicodeInfo_Numeric(ParamPrevious))
             ||
            (WWHUnicodeInfo_MidNum(ParamPrevious))
             ||
            (WWHUnicodeInfo_MidNumLet(ParamPrevious))
             ||
            (WWHUnicodeInfo_MidLetter(ParamPrevious))
             ||
            (WWHUnicodeInfo_Katakana(ParamPrevious))
             ||
            (WWHUnicodeInfo_Hiragana(ParamPrevious))
             ||
            (WWHUnicodeInfo_Ideographic(ParamPrevious))
             ||
            (WWHUnicodeInfo_Korean_L(ParamPrevious))
             ||
            (WWHUnicodeInfo_Korean_LV(ParamPrevious))
             ||
            (WWHUnicodeInfo_Korean_V(ParamPrevious))
             ||
            (WWHUnicodeInfo_Korean_LVT(ParamPrevious))
             ||
            (WWHUnicodeInfo_Korean_T(ParamPrevious))
             ||
            (WWHUnicodeInfo_Extend(ParamPrevious))
           )
            &&
           (
            (WWHUnicodeInfo_Extend(ParamCurrent))
           )
          )
  {
    VarResult = false;
  }
  else if (
           (
            (WWHUnicodeInfo_ALetter(ParamPrevious))
             ||
            (WWHUnicodeInfo_Extend(ParamPrevious))
           )
            &&
           (
            (WWHUnicodeInfo_ALetter(ParamCurrent))
           )
          )
  {
    VarResult = false;
  }
  else if (
           (
            (WWHUnicodeInfo_Katakana(ParamPrevious))
           )
            &&
           (
            (WWHUnicodeInfo_Katakana(ParamCurrent))
           )
          )
  {
    VarResult = false;
  }
  else if (
           (
            (WWHUnicodeInfo_Numeric(ParamPrevious))
             ||
            (WWHUnicodeInfo_MidNumLet(ParamPrevious))
             ||
            (WWHUnicodeInfo_MidLetter(ParamPrevious))
             ||
            (WWHUnicodeInfo_Extend(ParamPrevious))
           )
            &&
           (
            (WWHUnicodeInfo_ABaseLetter(ParamCurrent))
             ||
            (WWHUnicodeInfo_ACMLetter(ParamCurrent))
           )
          )
  {
    VarResult = false;
  }
  else if (
           (
            (WWHUnicodeInfo_ALetter(ParamPrevious))
             ||
            (WWHUnicodeInfo_ABaseLetter(ParamPrevious))
             ||
            (WWHUnicodeInfo_ACMLetter(ParamPrevious))
             ||
            (WWHUnicodeInfo_Extend(ParamPrevious))
           )
            &&
           (
            (WWHUnicodeInfo_MidNumLet(ParamCurrent))
             ||
            (WWHUnicodeInfo_MidLetter(ParamCurrent))
           )
          )
  {
    VarResult = false;
  }
  else if (
           (
            (WWHUnicodeInfo_ABaseLetter(ParamPrevious))
             ||
            (WWHUnicodeInfo_ACMLetter(ParamPrevious))
             ||
            (WWHUnicodeInfo_MidNum(ParamPrevious))
             ||
            (WWHUnicodeInfo_MidNumLet(ParamPrevious))
             ||
            (WWHUnicodeInfo_Numeric(ParamPrevious))
             ||
            (WWHUnicodeInfo_Extend(ParamPrevious))
           )
            &&
           (
            (WWHUnicodeInfo_Numeric(ParamCurrent))
           )
          )
  {
    VarResult = false;
  }
  else if (
           (
            (WWHUnicodeInfo_Numeric(ParamPrevious))
             ||
            (WWHUnicodeInfo_Extend(ParamPrevious))
           )
            &&
           (
            (WWHUnicodeInfo_MidNum(ParamCurrent))
             ||
            (WWHUnicodeInfo_MidNumLet(ParamCurrent))
           )
          )
  {
    VarResult = false;
  }
  else if (
           (
            (true)
           )
            &&
           (
            (WWHUnicodeInfo_Hiragana(ParamCurrent))
             ||
            (WWHUnicodeInfo_Ideographic(ParamCurrent))
           )
          )
  {
    VarResult = true;
  }
  else if (
           (
            (true)
           )
            &&
           (
            (WWHUnicodeInfo_WWCloseBracket(ParamCurrent))
           )
          )
  {
    VarResult = false;
  }
  else if (
           (
            (WWHUnicodeInfo_WWOpenBracket(ParamPrevious))
           )
            &&
           (
            (true)
           )
          )
  {
    VarResult = false;
  }

  return VarResult;
}

function WWHUnicode_CheckBreakAtIndex(ParamString,
                                      ParamIndex)
{
  var  VarResult = false;

  if (ParamIndex < ParamString.length)
  {
    if (ParamString.length == 1)
    {
      VarResult = false;
    }
    else if (ParamString.length > 1)
    {
      // String is at least two characters long
      //
      if (ParamIndex == 0)
      {
        VarResult = false;
      }
      else
      {
        VarResult = WWHUnicode_Break_CheckBreak_Sequence(ParamString.charAt(ParamIndex - 1), ParamString.charAt(ParamIndex));
      }
    }
  }

  return VarResult;
}
