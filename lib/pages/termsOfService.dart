import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:speedplanner/pages/privacyPolicy.dart';
import 'package:speedplanner/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsOfSerivceWidget extends StatefulWidget {
  const TermsOfSerivceWidget({Key key}) : super(key: key);

  @override
  _TermsOfSerivceWidgetState createState() => _TermsOfSerivceWidgetState();
}

class _TermsOfSerivceWidgetState extends State<TermsOfSerivceWidget> {
  bool _showBackToTopButton = false;

  ScrollController _scrollController;

  _launchUrl() async {
    const url = 'https://ginoquispe21.github.io/Speedplanner-LandingPage/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(seconds: 3), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(33.0),
            child: Text(
              "Condiciones de Servicio",
              style: TextStyle(fontSize: 16),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xff30B18B), Color(0xff8377d1)],
            )),
          ),
        ),
        body: Scrollbar(
          isAlwaysShown: true,
          showTrackOnHover: true,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Container(
                        height: 75,
                        width: 250,
                        child: Image.asset(
                          'assets/fasttech_logo.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Software de alta calidad con la finalidad de optimizar procesos complejos, tediosos o ineficientes",
                      style: TextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        child: Text(
                          "SPEEDPLANNER",
                          style: TextStyle(color: greenColor),
                        ),
                        onPressed: _launchUrl,
                      ),
                      TextButton(
                        child: Text("CONTACTANOS",
                            style: TextStyle(color: purpleColor)),
                        onPressed: () {},
                      )
                    ],
                  ),
                  Divider(
                    height: 20.0,
                    thickness: 0.5,
                    color: Color(0Xff707070),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 25),
                      child: Text(
                        "T??rminos y condiciones de FastTech",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Ultima actualizac??n: Julio 01, 2021"),
                        SizedBox(height: 10),
                        Text(
                            'Estos t??rminos y condiciones ("Acuerdo") establecen los t??rminos y condiciones generales de la empresa FastTech para el uso de la aplicaci??n m??vil "Speedplanner??? ("Aplicaci??n m??vil" o "Servicio") y cualquiera de sus productos y servicios relacionados (colectivamente, "Servicios???). Este Acuerdo es legalmente vinculante entre usted ("Usuario", "usted" o "su") y esta empresa desarrolladora de aplicaciones m??viles ("Operador", "nosotros", "nos" o "nuestro").  '),
                        SizedBox(height: 10),
                        Text(
                            'Al acceder y utilizar la Aplicaci??n y los Servicios m??viles, usted reconoce que ha le??do, comprendido y acepta regirse por los t??rminos de este Acuerdo. Si est?? celebrando este Acuerdo en nombre de una empresa u otra entidad legal, declara que tiene la autoridad para vincular a dicha entidad a este Acuerdo, en cuyo caso los t??rminos "Usuario", "usted" o "su" se referir??n a dicha entidad. Si no tiene dicha autoridad, o si no est?? de acuerdo con los t??rminos de este Acuerdo, no debe aceptar este Acuerdo y no puede acceder ni utilizar la Aplicaci??n y los Servicios m??viles. Usted reconoce que este Acuerdo es un contrato entre usted y el Operador, aunque es electr??nico y no est?? firmado f??sicamente por usted, y rige su uso de la Aplicaci??n y los Servicios m??viles. Esta pol??tica de t??rminos y condiciones se cre?? con la ayuda del generador de t??rminos y condiciones en https://www.websitepolicies.com/terms-and-conditions-generator. '),
                        SizedBox(height: 10),
                        Text(
                          "Cuentas y membres??a",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Debe tener al menos 13 a??os para utilizar la Aplicaci??n y los Servicios m??viles. Al utilizar la Aplicaci??n y los Servicios m??viles y al aceptar este Acuerdo, usted garantiza y declara que tiene al menos 13 a??os de edad. Si crea una cuenta en la Aplicaci??n m??vil, usted es responsable de mantener la seguridad de su cuenta y es completamente responsable de todas las actividades que ocurran en la cuenta y de cualquier otra acci??n que se tome en relaci??n con ella. Podemos, pero no tenemos la obligaci??n de hacerlo, monitorear y revisar nuevas cuentas antes de que pueda iniciar sesi??n y comenzar a usar los Servicios. Proporcionar informaci??n de contacto falsa de cualquier tipo puede resultar en la cancelaci??n de su cuenta. Debe notificarnos inmediatamente de cualquier uso no autorizado de su cuenta o cualquier otra violaci??n de seguridad. No seremos responsables de ning??n acto u omisi??n por su parte, incluyendo cualquier da??o de cualquier tipo incurrido como resultado de tales actos u omisiones. Podemos suspender, deshabilitar o eliminar su cuenta (o cualquier parte de la misma) si determinamos que ha violado alguna disposici??n de este Acuerdo o que su conducta o contenido tender??an a da??ar nuestra reputaci??n y buena voluntad. Si eliminamos su cuenta por los motivos anteriores, no podr?? volver a registrarse en nuestros Servicios. Podemos bloquear su direcci??n de correo electr??nico y su direcci??n de protocolo de Internet para evitar que se registren m??s. no puede volver a registrarse en nuestros Servicios. Podemos bloquear su direcci??n de correo electr??nico y su direcci??n de protocolo de Internet para evitar que se registren m??s. no puede volver a registrarse en nuestros Servicios. Podemos bloquear su direcci??n de correo electr??nico y su direcci??n de protocolo de Internet para evitar que se registren m??s.'),
                        SizedBox(height: 10),
                        Text(
                          "Contenido de usuario",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'No poseemos ning??n dato, informaci??n o material (colectivamente, "Contenido") que env??e en la Aplicaci??n m??vil durante el uso del Servicio. Usted ser?? el ??nico responsable de la precisi??n, calidad, integridad, legalidad, fiabilidad, idoneidad y propiedad intelectual o derecho de uso de todo el Contenido enviado. Podemos monitorear y revisar el Contenido en la Aplicaci??n m??vil enviada o creada usando nuestros Servicios por usted. Usted nos concede permiso para acceder, copiar, distribuir, almacenar, transmitir, reformatear, mostrar y ejecutar el Contenido de su cuenta de usuario ??nicamente seg??n sea necesario con el fin de proporcionarle los Servicios. Tambi??n nos otorga la licencia para usar, reproducir, adaptar, modificar, publicar o distribuir el Contenido creado por usted o almacenado en su cuenta de usuario para fines comerciales,'),
                        SizedBox(height: 10),
                        Text(
                          "Copias de seguridad",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Realizamos copias de seguridad peri??dicas del Contenido y haremos todo lo posible para garantizar la integridad y precisi??n de estas copias de seguridad. En caso de falla del hardware o p??rdida de datos, restauraremos las copias de seguridad autom??ticamente para minimizar el impacto y el tiempo de inactividad.'),
                        SizedBox(height: 10),
                        Text(
                          "Enlaces a otros recursos",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Aunque la Aplicaci??n y los Servicios m??viles pueden vincularse a otros recursos (como sitios web, aplicaciones m??viles, etc.), no estamos implicando, directa o indirectamente, ninguna aprobaci??n, asociaci??n, patrocinio, respaldo o afiliaci??n con ning??n recurso vinculado, a menos que espec??ficamente establecido en este documento. No somos responsables de examinar o evaluar, y no garantizamos las ofertas de ninguna empresa o individuo ni el contenido de sus recursos. No asumimos ninguna responsabilidad por las acciones, productos, servicios y contenido de otros terceros. Debe revisar cuidadosamente las declaraciones legales y otras condiciones de uso de cualquier recurso al que acceda a trav??s de un enlace en la Aplicaci??n y los Servicios m??viles. Su vinculaci??n a cualquier otro recurso fuera del sitio es bajo su propio riesgo.'),
                        SizedBox(height: 10),
                        Text(
                          "Usos prohibidos",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Adem??s de otros t??rminos establecidos en el Acuerdo, se le proh??be el uso de la Aplicaci??n m??vil y los Servicios o el Contenido: (a) para cualquier prop??sito ilegal; (b) solicitar a otros que realicen o participen en actos il??citos; (c) violar cualquier reglamento, regla, ley u ordenanza local internacional, federal, provincial o estatal; (d) infringir o violar nuestros derechos de propiedad intelectual o los derechos de propiedad intelectual de terceros; (e) acosar, abusar, insultar, da??ar, difamar, calumniar, menospreciar, intimidar o discriminar por motivos de g??nero, orientaci??n sexual, religi??n, etnia, raza, edad, nacionalidad o discapacidad; (f) enviar informaci??n falsa o enga??osa; (g) cargar o transmitir virus o cualquier otro tipo de c??digo malintencionado que se utilizar?? o se podr?? utilizar de cualquier forma que afecte la funcionalidad o el funcionamiento de la Aplicaci??n y los Servicios m??viles, los productos y servicios de terceros o Internet; (h) enviar spam, phishing, pharm, pretext, spider, crawl o scrape; (i) para cualquier prop??sito obsceno o inmoral; o (j) interferir o eludir las caracter??sticas de seguridad de la Aplicaci??n y los Servicios m??viles, los productos y servicios de terceros o Internet. Nos reservamos el derecho de terminar su uso de la Aplicaci??n y los Servicios m??viles por violar cualquiera de los usos prohibidos. o (j) interferir o eludir las caracter??sticas de seguridad de la Aplicaci??n y los Servicios m??viles, los productos y servicios de terceros o Internet. Nos reservamos el derecho de terminar su uso de la Aplicaci??n y los Servicios m??viles por violar cualquiera de los usos prohibidos. o (j) interferir o eludir las caracter??sticas de seguridad de la Aplicaci??n y los Servicios m??viles, los productos y servicios de terceros o Internet. Nos reservamos el derecho de terminar su uso de la Aplicaci??n y los Servicios m??viles por violar cualquiera de los usos prohibidos.'),
                        SizedBox(height: 10),
                        Text(
                          "Derechos de propiedad intelectual",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            '"Derechos de propiedad intelectual" significa todos los derechos presentes y futuros conferidos por estatuto, derecho consuetudinario o equidad en o en relaci??n con cualquier derecho de autor y derechos relacionados, marcas comerciales, dise??os, patentes, invenciones, buena voluntad y el derecho a demandar por la transferencia, invenciones, derechos de uso y todos los dem??s derechos de propiedad intelectual, en cada caso ya sean registrados o no registrados e incluyendo todas las aplicaciones y derechos para solicitar y ser otorgados, derechos para reclamar la prioridad de dichos derechos y todos los derechos o formas de derechos similares o equivalentes protecci??n y cualquier otro resultado de la actividad intelectual que subsista o subsistir?? ahora o en el futuro en cualquier parte del mundo. Este Acuerdo no le transfiere ninguna propiedad intelectual propiedad del Operador o de terceros, y todos los derechos, t??tulos, y los intereses en y para dicha propiedad permanecer??n (como entre las partes) ??nicamente con el Operador. Todas las marcas comerciales, marcas de servicio, gr??ficos y logotipos utilizados en relaci??n con la Aplicaci??n y los Servicios m??viles son marcas comerciales o marcas comerciales registradas del Operador o sus licenciantes. Otras marcas comerciales, marcas de servicio, gr??ficos y logotipos utilizados en relaci??n con la Aplicaci??n y los Servicios m??viles pueden ser marcas comerciales de terceros. El uso que haga de la Aplicaci??n y los Servicios m??viles no le otorga ning??n derecho o licencia para reproducir o utilizar de otro modo las marcas comerciales del Operador o de terceros. Otras marcas comerciales, marcas de servicio, gr??ficos y logotipos utilizados en relaci??n con la Aplicaci??n y los Servicios m??viles pueden ser marcas comerciales de terceros. El uso que haga de la Aplicaci??n y los Servicios m??viles no le otorga ning??n derecho o licencia para reproducir o utilizar de otro modo las marcas comerciales del Operador o de terceros. Otras marcas comerciales, marcas de servicio, gr??ficos y logotipos utilizados en relaci??n con la Aplicaci??n y los Servicios m??viles pueden ser marcas comerciales de terceros. El uso que haga de la Aplicaci??n y los Servicios m??viles no le otorga ning??n derecho o licencia para reproducir o utilizar de otro modo las marcas comerciales del Operador o de terceros.'),
                        SizedBox(height: 10),
                        Text(
                          "Limitaci??n de responsabilidad",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'En la m??xima medida permitida por la ley aplicable, en ning??n caso el Operador, sus afiliados, directores, funcionarios, empleados, agentes, proveedores o otorgantes de licencias ser??n responsables ante cualquier persona por da??os indirectos, incidentales, especiales, punitivos, de cobertura o consecuentes ( incluyendo, sin limitaci??n, da??os por lucro cesante, ingresos, ventas, buena voluntad, uso de contenido, impacto en el negocio, interrupci??n del negocio, p??rdida de ahorros anticipados, p??rdida de oportunidad de negocio) cualquiera que sea su causa, bajo cualquier teor??a de responsabilidad, incluyendo, sin limitaci??n , contrato, agravio, garant??a, incumplimiento del deber legal, negligencia o de otro tipo, incluso si la parte responsable ha sido informada sobre la posibilidad de tales da??os o podr??a haber previsto tales da??os. En la medida m??xima permitida por la ley aplicable, la responsabilidad total del Operador y sus afiliados, funcionarios, Los empleados, agentes, proveedores y otorgantes de licencias relacionados con los servicios estar??n limitados a un monto mayor de un d??lar o cualquier monto realmente pagado en efectivo por usted al Operador durante el per??odo de un mes anterior al primer evento u ocurrencia que dio lugar a tal responsabilidad. Las limitaciones y exclusiones tambi??n se aplican si este recurso no lo compensa completamente por las p??rdidas o no cumple con su prop??sito esencial.'),
                        SizedBox(height: 10),
                        Text(
                          "Indemnizaci??n",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Usted acepta indemnizar y eximir al Operador y a sus afiliados, directores, funcionarios, empleados, agentes, proveedores y otorgantes de licencias de y contra cualquier responsabilidad, p??rdida, da??o o costo, incluidos los honorarios razonables de abogados, incurridos en relaci??n con o derivados de cualquier alegaciones, reclamos, acciones, disputas o demandas de terceros contra cualquiera de ellos como resultado o en relaci??n con su Contenido, su uso de la Aplicaci??n m??vil y los Servicios o cualquier mala conducta intencional de su parte.'),
                        SizedBox(height: 10),
                        Text(
                          "Divisibilidad",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Todos los derechos y restricciones contenidos en este Acuerdo pueden ejercerse y ser??n aplicables y vinculantes solo en la medida en que no violen ninguna ley aplicable y est??n destinados a limitarse en la medida necesaria para que no hagan que este Acuerdo sea ilegal, inv??lido. o inaplicable. Si alguna disposici??n o parte de cualquier disposici??n de este Acuerdo se considera ilegal, inv??lida o inaplicable por un tribunal de jurisdicci??n competente, es la intenci??n de las partes que las disposiciones restantes o partes de las mismas constituyan su acuerdo con respecto al objeto del presente, y todas las disposiciones restantes o partes de las mismas permanecer??n en pleno vigor y efecto.'),
                        SizedBox(height: 10),
                        Text(
                          "Resoluci??n de conflictos",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'La formaci??n, interpretaci??n y ejecuci??n de este Acuerdo y cualquier disputa que surja de ??l se regir?? por las leyes sustantivas y procesales del Per?? sin tener en cuenta sus reglas sobre conflictos o elecci??n de leyes y, en la medida de lo aplicable, las leyes del Per??. . La jurisdicci??n exclusiva y el lugar para las acciones relacionadas con el objeto del presente ser??n los tribunales ubicados en Per??, y usted se somete a la jurisdicci??n personal de dichos tribunales. Por la presente, usted renuncia a cualquier derecho a un juicio con jurado en cualquier procedimiento que surja de o est?? relacionado con este Acuerdo. La Convenci??n de las Naciones Unidas sobre Contratos de Compraventa Internacional de Mercader??as no se aplica a este Acuerdo.'),
                        SizedBox(height: 10),
                        Text(
                          "Cambios y modificaciones",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Nos reservamos el derecho de modificar este Acuerdo o sus t??rminos relacionados con la Aplicaci??n y los Servicios m??viles en cualquier momento, a partir de la publicaci??n de una versi??n actualizada de este Acuerdo en la Aplicaci??n m??vil. Cuando lo hagamos, le enviaremos un correo electr??nico para notificarle. El uso continuado de la Aplicaci??n y los Servicios m??viles despu??s de dichos cambios constituir?? su consentimiento para dichos cambios.'),
                        SizedBox(height: 10),
                        Text(
                          "Aceptaci??n de estos t??rminos",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Usted reconoce que ha le??do este Acuerdo y acepta todos sus t??rminos y condiciones. Al acceder y utilizar la Aplicaci??n y los Servicios m??viles, usted acepta regirse por este Acuerdo. Si no acepta cumplir con los t??rminos de este Acuerdo, no est?? autorizado para acceder o utilizar la Aplicaci??n y los Servicios m??viles.'),
                        SizedBox(height: 10),
                        Text(
                          "Contactando con nosotros",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Si desea contactarnos para comprender m??s sobre este Acuerdo o desea contactarnos sobre cualquier asunto relacionado con el mismo, puede hacerlo a trav??s del formulario de contacto, enviar un correo electr??nico a speedplannerSupport@gmail.com o escribir una carta a Prolongaci??n Primavera. 2390, Lima 15023.'),
                        Divider(
                          height: 20.0,
                          thickness: 0.5,
                          color: Color(0Xff707070),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextButton(
                                child: _showBackToTopButton == false
                                    ? null
                                    : Text(
                                        "Terminos",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12),
                                      ),
                                onPressed: _scrollToTop,
                              ),
                              TextButton(
                                child: Text(
                                  "Privacidad",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                                onPressed: () {
                                  _showBackToTopButton = false;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PrivacyPolicyWidget()),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(EvaIcons.facebook),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(EvaIcons.twitter),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(EvaIcons.linkedin),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(EvaIcons.emailOutline),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
