
NOTE: 

There is an error showing in the log that it has nothing to do with the NOMAD or PAYMENT process, it's an IOS12 and XCODE 10 problem. 

The error is : 

"AVAudioSessionPortImpl.mm:56:ValidateRequiredFields: Unknown selected data source for Port Speaker (type: Speaker)"

The message Unknown selected data source for Port Speaker seems to be a problem with iOS 12. Apparently it's some warning that appears even if the code is working. Perhaps Apple will fix this soon, so maybe for now you can ignore this warning and once they find a solution you will be able to silence it.

Source: AVAudioSession errors in iOS 12

https://forums.developer.apple.com/thread/108785




# Multipagos Movil Nomad iOS ObjectiveC Demo

Aplicación genérica para sistema operativo iOS y lenguage de programación ObjectiveC que muestra un ejemplo de como conectarse al dipositivo PinPad Nomad y permite enviarle comandos. El dispositivo Nomad permite el la lectura de tarjetas presenciales. 

## Funcionalidades
* Conexion: Conectarse al dipositivo via Bluetooth
* Lectura de Tarjeta: Se inserta la tarjeta dentro de un dipositivo PINPAD para realizar la lectura


### _Frameworks_
* IOS HTTP REQUESTS
* BBPOS
* iOS SDK

### _Componente Final_
Archivo .framework
Archivo IPA

### Derechos de Autor de Terceros:
Dentro del desarrollo de nuestros programas se utilizan rutinas y programas desarrollados por terceros y que se han definido como OpenSource (software de código abierto) los cuales son publicados bajo una licencia de código abierto donde los derechos de autor permiten a los usuarios utilizar librerías, frameworks, etc.

La lista de OpenSource se puede consultar en el apartado [Frameworks](#Frameworks).
Update README.md
Derechos de Autor de Terceros


