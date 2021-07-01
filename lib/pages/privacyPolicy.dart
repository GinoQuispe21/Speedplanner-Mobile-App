import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:speedplanner/pages/termsOfService.dart';
import 'package:speedplanner/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyWidget extends StatefulWidget {
  const PrivacyPolicyWidget({Key key}) : super(key: key);

  @override
  _PrivacyPolicyWidgetState createState() => _PrivacyPolicyWidgetState();
}

class _PrivacyPolicyWidgetState extends State<PrivacyPolicyWidget> {
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
              "Políticas de Privacidad",
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
                      padding: const EdgeInsets.only(top: 80.0),
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
                  SizedBox(height: 20),
                  Divider(
                    height: 20.0,
                    thickness: 0.5,
                    color: Color(0Xff707070),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 25),
                      child: Text(
                        "Política de privacidad de FastTech",
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
                            "Esta Política de privacidad describe Nuestras políticas y procedimientos sobre la recopilación, uso y divulgación de Su información cuando usa el Servicio y le informa sobre Sus derechos de privacidad y cómo la ley lo protege."),
                        SizedBox(height: 10),
                        Text(
                            "Usamos sus datos personales para proporcionar y mejorar el servicio. Al utilizar el Servicio, acepta la recopilación y el uso de información de acuerdo con esta Política de privacidad. Esta Política de privacidad se ha creado con la ayuda del Privacy Policy Generator."),
                        SizedBox(height: 10),
                        Text(
                          "Interpretación y definiciones",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Interpretación",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                            "Las palabras cuya letra inicial está en mayúscula tienen significados definidos en las siguientes condiciones. Las siguientes definiciones tendrán el mismo significado independientemente de que aparezcan en singular o en plural."),
                        SizedBox(height: 5),
                        Text(
                          "Definiciones",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text("A los efectos de esta Política de privacidad:"),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Cuenta ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      'significa una cuenta única creada para que usted acceda a nuestro Servicio o partes de nuestro Servicio.')
                            ])),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Afiliado ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      'significa una entidad que controla, está controlada por o está bajo control común con una parte, donde "control" significa propiedad del 50% o más de las acciones, participación en el capital social u otros valores con derecho a voto para la elección de directores u otra autoridad de gestión.')
                            ])),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Aplicación ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      'significa el programa de software proporcionado por la Compañía descargado por Usted en cualquier dispositivo electrónico, llamado Speedplanner.')
                            ])),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Compañía ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      '(denominada "la Compañía", "Nosotros", "Nos" o "Nuestro" en este Acuerdo) se refiere a FastTech, Prolongación Primavera 2390, Lima 15023.')
                            ])),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • País ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(text: 'se refiere a: Perú')
                            ])),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Dispositivo ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      'significa cualquier dispositivo que pueda acceder al Servicio, como una computadora, un teléfono celular o una tableta digital.')
                            ])),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Los datos personales ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      'son cualquier información que se relacione con una persona identificada o identificable.')
                            ])),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Servicio ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(text: 'se refiere a la Aplicación.')
                            ])),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Proveedor de servicios ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      'significa cualquier persona física o jurídica que procesa los datos en nombre de la Compañía. Se refiere a empresas de terceros o personas empleadas por la Compañía para facilitar el Servicio, para proporcionar el Servicio en nombre de la Compañía, para realizar servicios relacionados con el Servicio o para ayudar a la Compañía a analizar cómo se utiliza el Servicio.')
                            ])),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Los Datos de uso  ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      'se refieren a los datos recopilados automáticamente, ya sea generados por el uso del Servicio o por la propia infraestructura del Servicio (por ejemplo, la duración de una visita a la página).')
                            ])),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Usted ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      'se refiere a la persona que accede o utiliza el Servicio, o la empresa u otra entidad legal en nombre de la cual dicha persona accede o utiliza el Servicio, según corresponda.')
                            ])),
                        SizedBox(height: 10),
                        Text(
                          "Recopilación y uso de datos personales",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Tipos de datos recopilados",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Información personal",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                            "Mientras usamos Nuestro Servicio, podemos pedirle que nos proporcione cierta información de identificación personal que pueda usarse para contactarlo o identificarlo. La información de identificación personal puede incluir, pero no se limita a:"),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(" • Dirección de correo electrónico"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(" • Nombre y apellido"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(" • Datos de uso"),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Datos de uso",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                            "Los datos de uso se recopilan automáticamente cuando se utiliza el servicio."),
                        SizedBox(height: 5),
                        Text(
                            "Los datos de uso pueden incluir información como la dirección de Protocolo de Internet de su dispositivo (por ejemplo, la dirección IP), el tipo de navegador, la versión del navegador, las páginas de nuestro Servicio que visita, la hora y fecha de su visita, el tiempo que pasó en esas páginas, dispositivo único identificadores y otros datos de diagnóstico."),
                        SizedBox(height: 5),
                        Text(
                            "Cuando accede al Servicio a través de un dispositivo móvil, podemos recopilar cierta información automáticamente, que incluye, entre otros, el tipo de dispositivo móvil que utiliza, la identificación única de su dispositivo móvil, la dirección IP de su dispositivo móvil, su dispositivo móvil sistema operativo, el tipo de navegador de Internet móvil que utiliza, identificadores de dispositivo únicos y otros datos de diagnóstico."),
                        SizedBox(height: 5),
                        Text(
                            "También podemos recopilar información que su navegador envía cada vez que visita nuestro Servicio o cuando accede al Servicio a través de un dispositivo móvil."),
                        SizedBox(height: 10),
                        Text(
                          "Uso de sus datos personales",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                            "La Compañía puede utilizar los Datos Personales para los siguientes propósitos:"),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text:
                                    ' • Para proporcionar y mantener nuestro Servicio, ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      'incluso para controlar el uso de nuestro Servicio.')
                            ])),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Para administrar Su Cuenta:  ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      'para administrar Su registro como usuario del Servicio. Los Datos Personales que proporcione pueden darle acceso a diferentes funcionalidades del Servicio que están disponibles para Usted como usuario registrado.')
                            ])),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Para la ejecución de un contrato: ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      'el desarrollo, cumplimiento y ejecución del contrato de compra de los productos, artículos o servicios que haya comprado o de cualquier otro contrato con Nosotros a través del Servicio.')
                            ])),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Para contactarlo: ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      'Para contactarlo por correo electrónico, llamadas telefónicas, SMS u otras formas equivalentes de comunicación electrónica, como las notificaciones push de una aplicación móvil sobre actualizaciones o comunicaciones informativas relacionadas con las funcionalidades, productos o servicios contratados, incluidas las actualizaciones de seguridad, cuando sea necesario o razonable para su implementación.')
                            ])),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Para proporcionarle  ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      'noticias, ofertas especiales e información general sobre otros bienes, servicios y eventos que ofrecemos y que son similares a los que ya ha comprado o sobre los que ha consultado, a menos que haya optado por no recibir dicha información.')
                            ])),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Para gestionar sus solicitudes: ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      'Para atender y gestionar sus solicitudes para nosotros.')
                            ])),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Para transferencias comerciales: ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      'podemos usar su información para evaluar o llevar a cabo una fusión, desinversión, reestructuración, reorganización, disolución u otra venta o transferencia de algunos o todos nuestros activos, ya sea como empresa en funcionamiento o como parte de una quiebra, liquidación, o procedimiento similar, en el que los Datos personales que tenemos sobre los usuarios de nuestro Servicio se encuentran entre los activos transferidos.')
                            ])),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Para otros fines: ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      'podemos utilizar su información para otros fines, como análisis de datos, identificación de tendencias de uso, determinación de la eficacia de nuestras campañas promocionales y para evaluar y mejorar nuestro Servicio, productos, servicios, marketing y su experiencia.')
                            ])),
                        SizedBox(height: 5),
                        Text(
                            "Podemos compartir su información personal en las siguientes situaciones: "),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Con proveedores de servicios: ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      'podemos compartir su información personal con proveedores de servicios para monitorear y analizar el uso de nuestro servicio, para comunicarnos con usted.')
                            ])),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Para transferencias comerciales: ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      'podemos compartir o transferir Su información personal en relación con, o durante las negociaciones de, cualquier fusión, venta de activos de la Compañía, financiamiento o adquisición de la totalidad o una parte de Nuestro negocio a otra compañía.')
                            ])),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Con afiliados: ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      'podemos compartir su información con nuestros afiliados, en cuyo caso les exigiremos que cumplan con esta Política de privacidad. Los afiliados incluyen nuestra empresa matriz y cualquier otra subsidiaria, socios de empresas conjuntas u otras empresas que controlemos o que estén bajo control común con nosotros.')
                            ])),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Con socios comerciales:  ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      'podemos compartir su información con nuestros socios comerciales para ofrecerle ciertos productos, servicios o promociones.')
                            ])),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Con otros usuarios: ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      'cuando comparte información personal o interactúa de otra manera en las áreas públicas con otros usuarios, dicha información puede ser vista por todos los usuarios y puede distribuirse públicamente en el exterior.')
                            ])),
                        SizedBox(height: 5),
                        RichText(
                            text: new TextSpan(
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontFamily: 'Poppins'),
                                children: <TextSpan>[
                              new TextSpan(
                                text: ' • Con su consentimiento: ',
                                style:
                                    new TextStyle(fontWeight: FontWeight.bold),
                              ),
                              new TextSpan(
                                  text:
                                      'podemos divulgar su información personal para cualquier otro propósito con su consentimiento.')
                            ])),
                        SizedBox(height: 10),
                        Text(
                          "Conservación de sus datos personales",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            "La Compañía retendrá sus datos personales solo durante el tiempo que sea necesario para los fines establecidos en esta Política de privacidad. Retendremos y usaremos sus datos personales en la medida necesaria para cumplir con nuestras obligaciones legales (por ejemplo, si estamos obligados a retener sus datos para cumplir con las leyes aplicables), resolver disputas y hacer cumplir nuestros acuerdos y políticas legales."),
                        SizedBox(height: 5),
                        Text(
                            "La Compañía también retendrá los Datos de uso con fines de análisis interno. Los datos de uso generalmente se conservan durante un período de tiempo más corto, excepto cuando estos datos se utilizan para fortalecer la seguridad o para mejorar la funcionalidad de nuestro servicio, o estamos legalmente obligados a conservar estos datos durante períodos de tiempo más prolongados."),
                        SizedBox(height: 10),
                        Text(
                          "Transferencia de sus datos personales",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            "Su información, incluidos los Datos personales, se procesa en las oficinas operativas de la Compañía y en cualquier otro lugar donde se encuentren las partes involucradas en el procesamiento. Significa que esta información puede transferirse y mantenerse en computadoras ubicadas fuera de su estado, provincia, país u otra jurisdicción gubernamental donde las leyes de protección de datos pueden diferir de las de su jurisdicción."),
                        SizedBox(height: 5),
                        Text(
                            "Su consentimiento a esta Política de privacidad seguido de Su envío de dicha información representa Su acuerdo con esa transferencia."),
                        SizedBox(height: 5),
                        Text(
                            "La Compañía tomará todas las medidas razonablemente necesarias para garantizar que Sus datos sean tratados de forma segura y de acuerdo con esta Política de Privacidad y no se realizará ninguna transferencia de Sus Datos Personales a una organización o país a menos que existan controles adecuados establecidos, incluida la seguridad de Tus datos y otra información personal."),
                        SizedBox(height: 10),
                        Text(
                          "Divulgación de sus datos personales",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Transacciones de negocios",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                            "Si la Compañía está involucrada en una fusión, adquisición o venta de activos, sus datos personales pueden ser transferidos. Le avisaremos antes de que sus datos personales se transfieran y estén sujetos a una política de privacidad diferente."),
                        SizedBox(height: 5),
                        Text(
                          "Cumplimiento de la ley",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                            "En determinadas circunstancias, es posible que se le solicite a la Compañía que revele sus datos personales si así lo exige la ley o en respuesta a solicitudes válidas de las autoridades públicas (por ejemplo, un tribunal o una agencia gubernamental)."),
                        SizedBox(height: 5),
                        Text(
                          "Otros requisitos legales",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                            "La Compañía puede divulgar sus datos personales con la creencia de buena fe de que dicha acción es necesaria para:"),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(" • Cumplir con una obligación legal"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                              " • Proteger y defender los derechos o propiedad de la Compañía."),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                              " • Prevenir o investigar posibles irregularidades en relación con el Servicio."),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                              " • Proteger la seguridad personal de los Usuarios del Servicio o del público."),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                              " • Protéjase contra la responsabilidad legal."),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Seguridad de sus datos personales",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            "La seguridad de sus datos personales es importante para nosotros, pero recuerde que ningún método de transmisión a través de Internet o método de almacenamiento electrónico es 100% seguro. Si bien nos esforzamos por utilizar medios comercialmente aceptables para proteger sus datos personales, no podemos garantizar su seguridad absoluta."),
                        SizedBox(height: 10),
                        Text(
                          "Privacidad de los niños",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            "Nuestro Servicio no se dirige a ninguna persona menor de 13 años. No recopilamos a sabiendas información de identificación personal de ninguna persona menor de 13 años. Si usted es un padre o tutor y sabe que su hijo nos ha proporcionado datos personales, por favor Contáctenos. Si nos damos cuenta de que hemos recopilado Datos personales de cualquier persona menor de 13 años sin verificación del consentimiento de los padres, tomamos medidas para eliminar esa información de Nuestros servidores."),
                        SizedBox(height: 5),
                        Text(
                            "Si necesitamos depender del consentimiento como base legal para procesar su información y su país requiere el consentimiento de uno de los padres, es posible que necesitemos el consentimiento de sus padres antes de recopilar y utilizar esa información."),
                        SizedBox(height: 10),
                        Text(
                          "Enlaces a otros sitios web",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            "Nuestro Servicio puede contener enlaces a otros sitios web que no son operados por Nosotros. Si hace clic en el enlace de un tercero, será dirigido al sitio de ese tercero. Le recomendamos encarecidamente que revise la Política de privacidad de cada sitio que visite."),
                        SizedBox(height: 5),
                        Text(
                            "No tenemos control ni asumimos ninguna responsabilidad por el contenido, las políticas de privacidad o las prácticas de sitios o servicios de terceros."),
                        SizedBox(height: 10),
                        Text(
                          "Cambios a esta política de privacidad",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            "Es posible que actualicemos nuestra Política de privacidad de vez en cuando. Le notificaremos de cualquier cambio publicando la nueva Política de privacidad en esta página."),
                        SizedBox(height: 5),
                        Text(
                            "Le informaremos por correo electrónico y / o un aviso destacado en Nuestro Servicio, antes de que el cambio entre en vigencia y actualizaremos la fecha de ´Última actualización´ en la parte superior de esta Política de privacidad."),
                        SizedBox(height: 5),
                        Text(
                            "Se le recomienda que revise esta Política de privacidad periódicamente para ver si hay cambios. Los cambios a esta Política de privacidad entran en vigencia cuando se publican en esta página."),
                        SizedBox(height: 10),
                        Text(
                          "Contáctenos",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                            "Si tiene alguna pregunta sobre esta Política de privacidad, puede contactarnos:"),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                              " • Por correo electrónico: speedplanner_support@gmail.com "),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                              " • Al visitar esta página en nuestro sitio web: https://ginoquispe21.github.io/Speedplanner-LandingPage/ "),
                        ),
                        SizedBox(height: 10),
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
                                child: Text(
                                  "Terminos",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TermsOfSerivceWidget()),
                                  );
                                },
                              ),
                              TextButton(
                                child: Text(
                                  "Privacidad",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                                onPressed: _scrollToTop,
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
