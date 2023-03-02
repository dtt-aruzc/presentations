import geb.spock.GebSpec
import groovy.json.JsonSlurper
import geb.Browser

class EnableAdminToLogInAsUsers extends GebSpec {

    def "enable admin to log in as users"() {

    when:
      def binary = "sfdx"
      if (System.getProperty("os.name").indexOf("Win") >= 0) binary+= ".cmd"
      binary += " force:org:open -r -p partnerbt/loginAccessPolicies.apexp?isdtp=p1 --json"
      def json = binary.execute().text
      def jsonSlurper = new JsonSlurper()
      def url = jsonSlurper.parseText(json)

      go url.result.url

    then:
      def title ="Políticas de acceso de inicio de sesión ~ Salesforce - Enterprise Edition";
      waitFor(30) { title.contains(title) }
      if($("input", id: "loginAccessPolicies:mainForm:j_id17:adminTable:0:adminsCanLogInAsAny", checked: "checked").isEmpty()){

        $("input", 0, id: "loginAccessPolicies:mainForm:j_id17:adminTable:0:adminsCanLogInAsAny").click();
        $("input", 0, id: "loginAccessPolicies:mainForm:j_id17:j_id22:bottom:save").click();

        waitFor(30) { title.contains(title) }
      }
    }
}