class Recipe
{
  constructor(ingredients, result)
  {
    this.ingredients = ingredients;
    this.result = result;
  }
  
  isValid(inputs)
  {
    // Check if ingredients are all inputs
    for (let ingredient of this.ingredients)
    {
      var isFound = false;
      for (let input of inputs)
      {
        if (input.name == ingredient.name)
        {
          isFound = true;
        }
      }
      if (isFound == false)
      {
        return false;
      }
    }
    
    // Check if inputs are all ingredients
    for (let input of inputs)
    {
      var isFound = false;
      for (let ingredient of this.ingredients)
      {
        if (input.name == ingredient.name)
        {
          isFound = true;
        }
      }
      if (isFound == false)
      {
        return false;
      }
    }
    return true;
  }
}
