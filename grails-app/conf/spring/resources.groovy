import security.UserPasswordEncoderListener

import grails.util.GrailsUtil


beans = {
    userPasswordEncoderListener(UserPasswordEncoderListener)
  customPropertyEditorRegistrar(util.CustomPropertyEditorRegistrar)

    localeResolver(org.springframework.web.servlet.i18n.SessionLocaleResolver) {
      defaultLocale = new Locale("en","EN")
//      defaultLocale = new Locale("ar","AR")
    //  java.util.Locale.setDefault(defaultLocale)
    }
}
