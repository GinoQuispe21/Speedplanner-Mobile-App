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
                        "Términos y condiciones de FastTech",
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
                        Text("Ultima actualizacín: Julio 01, 2021"),
                        SizedBox(height: 10),
                        Text(
                            'Estos términos y condiciones ("Acuerdo") establecen los términos y condiciones generales de la empresa FastTech para el uso de la aplicación móvil "Speedplanner” ("Aplicación móvil" o "Servicio") y cualquiera de sus productos y servicios relacionados (colectivamente, "Servicios”). Este Acuerdo es legalmente vinculante entre usted ("Usuario", "usted" o "su") y esta empresa desarrolladora de aplicaciones móviles ("Operador", "nosotros", "nos" o "nuestro").  '),
                        SizedBox(height: 10),
                        Text(
                            'Al acceder y utilizar la Aplicación y los Servicios móviles, usted reconoce que ha leído, comprendido y acepta regirse por los términos de este Acuerdo. Si está celebrando este Acuerdo en nombre de una empresa u otra entidad legal, declara que tiene la autoridad para vincular a dicha entidad a este Acuerdo, en cuyo caso los términos "Usuario", "usted" o "su" se referirán a dicha entidad. Si no tiene dicha autoridad, o si no está de acuerdo con los términos de este Acuerdo, no debe aceptar este Acuerdo y no puede acceder ni utilizar la Aplicación y los Servicios móviles. Usted reconoce que este Acuerdo es un contrato entre usted y el Operador, aunque es electrónico y no está firmado físicamente por usted, y rige su uso de la Aplicación y los Servicios móviles. Esta política de términos y condiciones se creó con la ayuda del generador de términos y condiciones en https://www.websitepolicies.com/terms-and-conditions-generator. '),
                        SizedBox(height: 10),
                        Text(
                          "Cuentas y membresía",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Debe tener al menos 13 años para utilizar la Aplicación y los Servicios móviles. Al utilizar la Aplicación y los Servicios móviles y al aceptar este Acuerdo, usted garantiza y declara que tiene al menos 13 años de edad. Si crea una cuenta en la Aplicación móvil, usted es responsable de mantener la seguridad de su cuenta y es completamente responsable de todas las actividades que ocurran en la cuenta y de cualquier otra acción que se tome en relación con ella. Podemos, pero no tenemos la obligación de hacerlo, monitorear y revisar nuevas cuentas antes de que pueda iniciar sesión y comenzar a usar los Servicios. Proporcionar información de contacto falsa de cualquier tipo puede resultar en la cancelación de su cuenta. Debe notificarnos inmediatamente de cualquier uso no autorizado de su cuenta o cualquier otra violación de seguridad. No seremos responsables de ningún acto u omisión por su parte, incluyendo cualquier daño de cualquier tipo incurrido como resultado de tales actos u omisiones. Podemos suspender, deshabilitar o eliminar su cuenta (o cualquier parte de la misma) si determinamos que ha violado alguna disposición de este Acuerdo o que su conducta o contenido tenderían a dañar nuestra reputación y buena voluntad. Si eliminamos su cuenta por los motivos anteriores, no podrá volver a registrarse en nuestros Servicios. Podemos bloquear su dirección de correo electrónico y su dirección de protocolo de Internet para evitar que se registren más. no puede volver a registrarse en nuestros Servicios. Podemos bloquear su dirección de correo electrónico y su dirección de protocolo de Internet para evitar que se registren más. no puede volver a registrarse en nuestros Servicios. Podemos bloquear su dirección de correo electrónico y su dirección de protocolo de Internet para evitar que se registren más.'),
                        SizedBox(height: 10),
                        Text(
                          "Contenido de usuario",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'No poseemos ningún dato, información o material (colectivamente, "Contenido") que envíe en la Aplicación móvil durante el uso del Servicio. Usted será el único responsable de la precisión, calidad, integridad, legalidad, fiabilidad, idoneidad y propiedad intelectual o derecho de uso de todo el Contenido enviado. Podemos monitorear y revisar el Contenido en la Aplicación móvil enviada o creada usando nuestros Servicios por usted. Usted nos concede permiso para acceder, copiar, distribuir, almacenar, transmitir, reformatear, mostrar y ejecutar el Contenido de su cuenta de usuario únicamente según sea necesario con el fin de proporcionarle los Servicios. También nos otorga la licencia para usar, reproducir, adaptar, modificar, publicar o distribuir el Contenido creado por usted o almacenado en su cuenta de usuario para fines comerciales,'),
                        SizedBox(height: 10),
                        Text(
                          "Copias de seguridad",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Realizamos copias de seguridad periódicas del Contenido y haremos todo lo posible para garantizar la integridad y precisión de estas copias de seguridad. En caso de falla del hardware o pérdida de datos, restauraremos las copias de seguridad automáticamente para minimizar el impacto y el tiempo de inactividad.'),
                        SizedBox(height: 10),
                        Text(
                          "Enlaces a otros recursos",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Aunque la Aplicación y los Servicios móviles pueden vincularse a otros recursos (como sitios web, aplicaciones móviles, etc.), no estamos implicando, directa o indirectamente, ninguna aprobación, asociación, patrocinio, respaldo o afiliación con ningún recurso vinculado, a menos que específicamente establecido en este documento. No somos responsables de examinar o evaluar, y no garantizamos las ofertas de ninguna empresa o individuo ni el contenido de sus recursos. No asumimos ninguna responsabilidad por las acciones, productos, servicios y contenido de otros terceros. Debe revisar cuidadosamente las declaraciones legales y otras condiciones de uso de cualquier recurso al que acceda a través de un enlace en la Aplicación y los Servicios móviles. Su vinculación a cualquier otro recurso fuera del sitio es bajo su propio riesgo.'),
                        SizedBox(height: 10),
                        Text(
                          "Usos prohibidos",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Además de otros términos establecidos en el Acuerdo, se le prohíbe el uso de la Aplicación móvil y los Servicios o el Contenido: (a) para cualquier propósito ilegal; (b) solicitar a otros que realicen o participen en actos ilícitos; (c) violar cualquier reglamento, regla, ley u ordenanza local internacional, federal, provincial o estatal; (d) infringir o violar nuestros derechos de propiedad intelectual o los derechos de propiedad intelectual de terceros; (e) acosar, abusar, insultar, dañar, difamar, calumniar, menospreciar, intimidar o discriminar por motivos de género, orientación sexual, religión, etnia, raza, edad, nacionalidad o discapacidad; (f) enviar información falsa o engañosa; (g) cargar o transmitir virus o cualquier otro tipo de código malintencionado que se utilizará o se podrá utilizar de cualquier forma que afecte la funcionalidad o el funcionamiento de la Aplicación y los Servicios móviles, los productos y servicios de terceros o Internet; (h) enviar spam, phishing, pharm, pretext, spider, crawl o scrape; (i) para cualquier propósito obsceno o inmoral; o (j) interferir o eludir las características de seguridad de la Aplicación y los Servicios móviles, los productos y servicios de terceros o Internet. Nos reservamos el derecho de terminar su uso de la Aplicación y los Servicios móviles por violar cualquiera de los usos prohibidos. o (j) interferir o eludir las características de seguridad de la Aplicación y los Servicios móviles, los productos y servicios de terceros o Internet. Nos reservamos el derecho de terminar su uso de la Aplicación y los Servicios móviles por violar cualquiera de los usos prohibidos. o (j) interferir o eludir las características de seguridad de la Aplicación y los Servicios móviles, los productos y servicios de terceros o Internet. Nos reservamos el derecho de terminar su uso de la Aplicación y los Servicios móviles por violar cualquiera de los usos prohibidos.'),
                        SizedBox(height: 10),
                        Text(
                          "Derechos de propiedad intelectual",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            '"Derechos de propiedad intelectual" significa todos los derechos presentes y futuros conferidos por estatuto, derecho consuetudinario o equidad en o en relación con cualquier derecho de autor y derechos relacionados, marcas comerciales, diseños, patentes, invenciones, buena voluntad y el derecho a demandar por la transferencia, invenciones, derechos de uso y todos los demás derechos de propiedad intelectual, en cada caso ya sean registrados o no registrados e incluyendo todas las aplicaciones y derechos para solicitar y ser otorgados, derechos para reclamar la prioridad de dichos derechos y todos los derechos o formas de derechos similares o equivalentes protección y cualquier otro resultado de la actividad intelectual que subsista o subsistirá ahora o en el futuro en cualquier parte del mundo. Este Acuerdo no le transfiere ninguna propiedad intelectual propiedad del Operador o de terceros, y todos los derechos, títulos, y los intereses en y para dicha propiedad permanecerán (como entre las partes) únicamente con el Operador. Todas las marcas comerciales, marcas de servicio, gráficos y logotipos utilizados en relación con la Aplicación y los Servicios móviles son marcas comerciales o marcas comerciales registradas del Operador o sus licenciantes. Otras marcas comerciales, marcas de servicio, gráficos y logotipos utilizados en relación con la Aplicación y los Servicios móviles pueden ser marcas comerciales de terceros. El uso que haga de la Aplicación y los Servicios móviles no le otorga ningún derecho o licencia para reproducir o utilizar de otro modo las marcas comerciales del Operador o de terceros. Otras marcas comerciales, marcas de servicio, gráficos y logotipos utilizados en relación con la Aplicación y los Servicios móviles pueden ser marcas comerciales de terceros. El uso que haga de la Aplicación y los Servicios móviles no le otorga ningún derecho o licencia para reproducir o utilizar de otro modo las marcas comerciales del Operador o de terceros. Otras marcas comerciales, marcas de servicio, gráficos y logotipos utilizados en relación con la Aplicación y los Servicios móviles pueden ser marcas comerciales de terceros. El uso que haga de la Aplicación y los Servicios móviles no le otorga ningún derecho o licencia para reproducir o utilizar de otro modo las marcas comerciales del Operador o de terceros.'),
                        SizedBox(height: 10),
                        Text(
                          "Limitación de responsabilidad",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'En la máxima medida permitida por la ley aplicable, en ningún caso el Operador, sus afiliados, directores, funcionarios, empleados, agentes, proveedores o otorgantes de licencias serán responsables ante cualquier persona por daños indirectos, incidentales, especiales, punitivos, de cobertura o consecuentes ( incluyendo, sin limitación, daños por lucro cesante, ingresos, ventas, buena voluntad, uso de contenido, impacto en el negocio, interrupción del negocio, pérdida de ahorros anticipados, pérdida de oportunidad de negocio) cualquiera que sea su causa, bajo cualquier teoría de responsabilidad, incluyendo, sin limitación , contrato, agravio, garantía, incumplimiento del deber legal, negligencia o de otro tipo, incluso si la parte responsable ha sido informada sobre la posibilidad de tales daños o podría haber previsto tales daños. En la medida máxima permitida por la ley aplicable, la responsabilidad total del Operador y sus afiliados, funcionarios, Los empleados, agentes, proveedores y otorgantes de licencias relacionados con los servicios estarán limitados a un monto mayor de un dólar o cualquier monto realmente pagado en efectivo por usted al Operador durante el período de un mes anterior al primer evento u ocurrencia que dio lugar a tal responsabilidad. Las limitaciones y exclusiones también se aplican si este recurso no lo compensa completamente por las pérdidas o no cumple con su propósito esencial.'),
                        SizedBox(height: 10),
                        Text(
                          "Indemnización",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Usted acepta indemnizar y eximir al Operador y a sus afiliados, directores, funcionarios, empleados, agentes, proveedores y otorgantes de licencias de y contra cualquier responsabilidad, pérdida, daño o costo, incluidos los honorarios razonables de abogados, incurridos en relación con o derivados de cualquier alegaciones, reclamos, acciones, disputas o demandas de terceros contra cualquiera de ellos como resultado o en relación con su Contenido, su uso de la Aplicación móvil y los Servicios o cualquier mala conducta intencional de su parte.'),
                        SizedBox(height: 10),
                        Text(
                          "Divisibilidad",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Todos los derechos y restricciones contenidos en este Acuerdo pueden ejercerse y serán aplicables y vinculantes solo en la medida en que no violen ninguna ley aplicable y estén destinados a limitarse en la medida necesaria para que no hagan que este Acuerdo sea ilegal, inválido. o inaplicable. Si alguna disposición o parte de cualquier disposición de este Acuerdo se considera ilegal, inválida o inaplicable por un tribunal de jurisdicción competente, es la intención de las partes que las disposiciones restantes o partes de las mismas constituyan su acuerdo con respecto al objeto del presente, y todas las disposiciones restantes o partes de las mismas permanecerán en pleno vigor y efecto.'),
                        SizedBox(height: 10),
                        Text(
                          "Resolución de conflictos",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'La formación, interpretación y ejecución de este Acuerdo y cualquier disputa que surja de él se regirá por las leyes sustantivas y procesales del Perú sin tener en cuenta sus reglas sobre conflictos o elección de leyes y, en la medida de lo aplicable, las leyes del Perú. . La jurisdicción exclusiva y el lugar para las acciones relacionadas con el objeto del presente serán los tribunales ubicados en Perú, y usted se somete a la jurisdicción personal de dichos tribunales. Por la presente, usted renuncia a cualquier derecho a un juicio con jurado en cualquier procedimiento que surja de o esté relacionado con este Acuerdo. La Convención de las Naciones Unidas sobre Contratos de Compraventa Internacional de Mercaderías no se aplica a este Acuerdo.'),
                        SizedBox(height: 10),
                        Text(
                          "Cambios y modificaciones",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Nos reservamos el derecho de modificar este Acuerdo o sus términos relacionados con la Aplicación y los Servicios móviles en cualquier momento, a partir de la publicación de una versión actualizada de este Acuerdo en la Aplicación móvil. Cuando lo hagamos, le enviaremos un correo electrónico para notificarle. El uso continuado de la Aplicación y los Servicios móviles después de dichos cambios constituirá su consentimiento para dichos cambios.'),
                        SizedBox(height: 10),
                        Text(
                          "Aceptación de estos términos",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Usted reconoce que ha leído este Acuerdo y acepta todos sus términos y condiciones. Al acceder y utilizar la Aplicación y los Servicios móviles, usted acepta regirse por este Acuerdo. Si no acepta cumplir con los términos de este Acuerdo, no está autorizado para acceder o utilizar la Aplicación y los Servicios móviles.'),
                        SizedBox(height: 10),
                        Text(
                          "Contactando con nosotros",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Si desea contactarnos para comprender más sobre este Acuerdo o desea contactarnos sobre cualquier asunto relacionado con el mismo, puede hacerlo a través del formulario de contacto, enviar un correo electrónico a speedplannerSupport@gmail.com o escribir una carta a Prolongación Primavera. 2390, Lima 15023.'),
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
