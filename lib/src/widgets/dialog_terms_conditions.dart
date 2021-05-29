  
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
showPopTermsConditions({
    context, 
    Function funcOkButton, 
  }){
    showGeneralDialog(
      transitionBuilder: (context, a1, a2, widget){
        final curvedValue = Curves.easeInOutBack.transform ( 1.0) - (a1.value);
        return Builder(
          builder: (BuildContext context) { 
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title:  Text(
                    "Crear cuenta",
                    style: TextStyle(color: Color(0xff1ba6d2),fontSize: 17),
                  ),
                  centerTitle: true,
                ),
                body: Container(
                  height: 100.0.h,
                  child: ListView(
                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 3.0.w,),
                        child: Container(
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0.w),
                              child: ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  SizedBox(height: 1.0.h,),
                                  Text("Términos y condiciones", style: TextStyle(color: Color(0xff1ba6d2), fontFamily: "Roboto-bold", fontSize: 15.0.sp),),
                                  Text(
                                    "Estimado visitante, antes de acceder a este medio, solicitamos leer cuidadosamente los términos, condiciones y reglamento, en adelante “TCR” para poder usar la Plataforma Web y la Aplicación o App, en adelante el “Sitio”, “Sitio Woin” o “Web/AppWoin”, el Programa o Sistema de Compensación Woin, en adelante el “Programa” o “Programa Woin”, “Sistema” o “Sistema Woin” de la empresa WOIN S.A.S., en adelante “WOIN”. \nAl ingresar estarás aceptando en su totalidad los TCR, si no cumples con los requisitos aquí descritos no podrás continuar con el registro, por tanto, deberá abstenerse de continuar con el registro, en caso de haber completado el registro, agradecemos que eliminar su cuenta inmediatamente para no recibir los beneficios y servicios ofrecidos por WOIN sus Usuarios y Comercios Aliados.\nSolo podrán registrarse las personas mayores de 18 años que entiende coherentemente los TCR establecidos por WOIN. \nSi el visitante está de acuerdo con nuestros TCR puede proceder con su registro, en adelante “Usuario” o “Woiner”, en plural “Usuarios” o “Woiners”.\n Deberá seleccionar una clasificación de Usuario como cliente(s), comprador(es) o consumidor(es), en adelante “Cliwoin” o “Cliente” y en plural “Cliwoins” o “Clientes”, y empresario(s), comercio(s), negocio(s), establecimiento(s), industria(s) o aliado(s), en adelante “Emwoin”, “Aliado”, “Comercio” o “Comercio Aliado” y en plural “Emwoins”, “Aliados”, “Comercios” o “Comercios Aliados”. Quien deberá tener un nombre de Usuario personal, clave o contraseña y un pin para las transacciones de Cupones. \nLuego recibirá un correo electrónico y/o un mensaje a su teléfono móvil con los pasos para finalizar la aprobación de su registro.\n Cada Usuario tendrá una cuenta para almacenar sus puntos, en adelante “Cuenta” o “Cuenta Woin” en plural “Cuentas” o “Cuentas Woins”Una vez registrado en WOIN la permanencia es indefinida, hasta que el Usuario lo decida. WOIN podrá eliminar la cuenta del Usuario si incumple los términos, reglamentos y condiciones establecidos por WOIN. Los incumplimientos de los TCR darán lugar a sanciones disciplinarias, económicas y jurídicas, por ende, deberá abstenerse de utilizar el Programa y demás servicios que esta ofrece",
                                    style: TextStyle(),
                                    textAlign: TextAlign.justify,
                                  ),
                                   SizedBox(height: 1.0.h,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.0.h,),
                      Container(
                        height: 7.0.h,
                        width: 100.0.w,
                        color:Colors.white,
                        child:Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RaisedButton(
                              elevation: 0,
                              child: Container(
                                width: 35.0.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.close,
                                      size:12.0.sp,
                                      color: Color(0xff1ba6d2),
                                    ),
                                    Text(
                                      'Cancelar',
                                      style: TextStyle(
                                      fontFamily: "Roboto",
                                      color: Color(0xff1ba6d2),
                                      fontSize:12.0.sp),
                                    ),
                                  ],
                                ),
                              ),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.of(context).pop();
                              }
                            ),
                            RaisedButton(
                              elevation: 0,
                              child: Container(
                                width: 35.0.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Continuar',
                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                        color: Colors.white,
                                        fontSize: 12.0.sp
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * 0.03,
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 2.7.sp,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              color: Color(0xff1ba6d2),
                              onPressed: funcOkButton
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ),
            );
          },
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {}
    );
  }
