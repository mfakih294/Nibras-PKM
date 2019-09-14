package util

import java.text.SimpleDateFormat
import org.springframework.beans.propertyeditors.CustomDateEditor 
import org.springframework.beans.PropertyEditorRegistrar 
import org.springframework.beans.PropertyEditorRegistry 

public class CustomPropertyEditorRegistrar implements PropertyEditorRegistrar { 
  public void registerCustomEditors(PropertyEditorRegistry registry) { 
  /* to ensure that the date text from jquery date picker, set in format dd.MM.yyyy, is binding without manual parsing */
      registry.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("dd.MM.yyyy"), true)); 
  } 
}