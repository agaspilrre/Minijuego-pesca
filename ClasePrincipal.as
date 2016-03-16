package  {
	//clase principal donde ejecutaremos el codigo de juego general.
	import flash.display.MovieClip;//importamos todas las clases a las que vayamos a llamar a sus metodos posteriormente
	import ClaseBotonInicio;
	import flash.display.Stage;
	import ClasePezBueno;
	import ClasePezMalo;
	import flash.events.MouseEvent;//para eventos de raton
	import flash.text.TextField;//para las instrucciones y demas cuadros de texto
	import EventoPez;
	import flash.events.Event;//eventos
	import flash.utils.Timer;//timer
	import flash.events.TimerEvent;
	//import fl.motion.Animator3D;
	
	
	
	public class ClasePrincipal extends MovieClip {
		
		
		//ATRIBUTOS
		private var boton:ClaseBotonInicio;
		private var stagePrincipal:Stage;
		//private var pezB:ClasePezBueno;
		private var cajaTexto:TextField;//para las instrucciones
		private var fin:TextField;
		private var arrayPeces:Array = new Array();
		private var arrayPecesMalos:Array=new Array();//prueba
		
		private var timerGenerador:Timer;
		private var timerGeneradorMalos:Timer;//prueba
		
		private var contador:int;//prueba
		private var textoContador:TextField;//prueba
		private var timerContador:Timer;//prueba
		private var ganar:TextField;//prueba
		
		
		
		
		
		public function ClasePrincipal() {
			// constructor code
			this.cajaTexto=new TextField();//cuando hago el new es cuando ya tengo creado el objeto.
			//tb se puede declarar el objeto en una sola linea asi private         var cajaTexto:TextField=new TextField;
			
										
			 							
										
			this.cajaTexto.x=50;
			this.cajaTexto.y=5;  // esto son las coordenadas para desplazar el texto en la pantalla de compilacion sinedo la coordenada 0 0 la esquina izq de la pantalla
			
			
		    this.cajaTexto.autoSize = "left";//esto me amplia la caja de texfield para que me aparezca todo el texto 
			this.cajaTexto.text="INSTRUCCIONES\n Salva a Makumba del hambre pescando peces antes de que el contador llegue a 0\n cuidado con los peces venenosos\n PULSA EL ICONO CENTRAL PARA EMPEZAR";
			
			this.addChild(this.cajaTexto);//muestro el texto en pantalla
			
			
			
			
			
			this.stagePrincipal=this.stage;//le asigno el valor de esta pantalla a stagePrincipal
			
			boton=new ClaseBotonInicio();//me creo un objeto boton de tipoclase boton inicio
			boton.x=this.stagePrincipal.stageWidth/2;
			boton.y=this.stagePrincipal.stageHeight/2;//le digo que las coordenadas del boton sean en el centro de la pantalla
			
			this.addChild(boton);//utilizo el metodo addchild para mostrar el boton por pantalla
			//nota: el simbolo boton tiene programado codigo en los fotogramas.
			
			this.boton.addEventListener(MouseEvent.MOUSE_DOWN,empezarMovPez);//le pongo boton porque si no al pinchar en el texfiel tambien se inicia al esperar evento MOUSEDOWN
		}
		
		//metodo que que llama a los pecesbuenos para que sagan en pantalla
		private function empezarMovPez(me:MouseEvent):void{
			this.removeChild(cajaTexto);//para quitar las instrucciones
			this.removeChild(boton);//para quitar el boton del centro de la pantalla una vez pulsado
			
			//ahora muestro el contador
			//this.cont=new ClaseContador(this.stage);//me creo el objeto contador
			//this.addChild(cont);//lo muestro en pantalla con addchild
			this.textoContador=new TextField();//creamos un objeto de tipo texfield para crear una caja de texto que es donde visualizaremos el contador
			this.textoContador.x=50;
			this.textoContador.y=5;  // esto son las coordenadas para desplazar el texto en la pantalla de compilacion sinedo la coordenada 0 0 la esquina izq de la pantalla
			
			
		    this.textoContador.autoSize = "left";//esto me amplia la caja de texfield para que me aparezca todo el texto 
			
		    this.contador=20;//inicializamos la variable contador y le damos el valor de 20 ya que queremos que la cuenta atras comience desde ese numero
			//ponemos esto aqui para que nos muestre tambien el numero 20.
			this.textoContador.text=contador.toString();//hacemos una conversion de contador que es int a tipo string para poder mostrarlo en la caja de texto
			this.addChild(this.textoContador);
			
			timerContador=new Timer(1000,0);//creo un objeto de tipo timer y le paso 1000 de parametro porque quiero que vaya contando cada segundo
			timerContador.addEventListener(TimerEvent.TIMER,CuentaAtras);//escuchador de evento que esta pendiente de la variable tiempo y cuando esta se inicia llama a la funcion de cuentaatras
			timerContador.start();//iniciamos el timer
			
			//timer para generar los peces
			timerGenerador = new Timer(1000, 0);//queremos que mande señal cada segundo numero infinito de veces
			timerGenerador.addEventListener(TimerEvent.TIMER, crearPeces, false, 0, true);//FALSE 0 TRUE son valores por defecto indica que cuando se destruya el objeto completamente del que esta pendiente automaticamente se desactive el addeventlistener
			timerGenerador.start();
			
			
			timerGeneradorMalos = new Timer(4000, 0);
			timerGeneradorMalos.addEventListener(TimerEvent.TIMER, crearPecesMalos, false, 0, true);
			timerGeneradorMalos.start();
			
			
			
		}
		//funcion que genera los peces buenos
		private function crearPeces(te:TimerEvent):void{
			
			var delayCrearPeces:Number = Math.random()*2000 + 1000;//genera peces entre uno y 3 segundos
			timerGenerador.delay = delayCrearPeces;//atributo de timer que retarda la generacion de peces y se lo igualamos a la variable que guarda el ramdom para que los peces tarden de 1 a tres segundos en generarse entre pez y pez
			
			
			var pez:ClasePezBueno = new ClasePezBueno (this.stage);
			pez.addEventListener(EventoPez.DESAPARECER_PEZ, pezVuelveAlRio, false, 0, true);//aqui esta pendiente de que el pez vuelva al rio
			pez.addEventListener(MouseEvent.CLICK, pezCazado, false, 0, true);//aqui esta pendiente de si el raton clica en el pez
			this.addChild(pez);//muestra en pantalla el pez
			arrayPeces.push(pez); //añade un elemento al array de peces
			
			
			
			
			
					
		}
		
		
		//funcion que genera los peces malos
		private function crearPecesMalos(te:TimerEvent):void{
			
			
			
			var delayCrearPecesMalos:Number = Math.random()*7000 + 1000;// genra los peces malos entre uno y 7 segundos
			timerGeneradorMalos.delay = delayCrearPecesMalos;//esto puede dar error y si da es xq hay que crear otro evento generador
			
			
			
			
			var pezM:ClasePezMalo = new ClasePezMalo (this.stage);
			pezM.addEventListener(EventoPez.DESAPARECER_PEZ, pezMaloVuelveAlRio, false, 0, true);
			pezM.addEventListener(MouseEvent.CLICK, pezMaloCazado, false, 0, true);
			this.addChild(pezM);
			arrayPeces.push(pezM); 
			
			
					
		}
		
		private function pezVuelveAlRio(ep:EventoPez):void{
			//target referencia a un objeto
			var pez:ClasePezBueno = ClasePezBueno(ep.target);//guarda el pez que ha vuelto al rio en esa variable para mandarlo a la funcion eliminar pez
			//quita puntuacion
			this.contador-=5;
			this.eliminarPez(pez);//llamo a la funcion eliminar pez y le paso el pez que he guardado en la variable que es el pez que ha vuelto al rio
			
		
		}
		//PRUEBA
		private function pezMaloVuelveAlRio(ep:EventoPez):void{
			
			var pezM:ClasePezMalo = ClasePezMalo(ep.target);
			
			
			this.eliminarPezM(pezM);
			
		
		}
		
		
		
		private function pezCazado(me:MouseEvent):void{
			
			var pez:ClasePezBueno = ClasePezBueno(me.target);//igual que antes pero guarda el pez que fue clicado por el raton ya que la funcion recibe un parametro mouseevent
			
			//suma puntuacion
			this.contador+=20;
			this.eliminarPez(pez);//pasamos el pez seleccionado con el raton a la funcion eliminar pez
		
		}
		
		
		private function pezMaloCazado(me:MouseEvent):void{
			
			var pezM:ClasePezMalo = ClasePezMalo(me.target);
			
			//quitar  puntuacion
			this.contador-=15;
			this.eliminarPezM(pezM);
		
		}
		
		
		//quita los peces del array y la pantalla
		private function eliminarPez(pez:ClasePezBueno):void{
			var i:int = this.arrayPeces.indexOf(pez);//te creas un contador y lo igualas indexof te localiza la posicion en el array del pez que recibio como parametro
			this.arrayPeces.splice(i, 1);//splice elimina el elemeno de la posicion  del array que le indicamos con el contador i y el uno nos dice que solo eliminemos un elemento a partir de esa posicion
			pez.pararPez();//metodo de la clasepez para que desactive todos los twin
			this.removeChild(pez);//quitamos el pez de pantalla
			pez = null;// con esto se elimina el pez del todo
		}
		
		
		
		
		private function eliminarPezM(pezM:ClasePezMalo):void{
			var i:int = this.arrayPecesMalos.indexOf(pezM);
			this.arrayPecesMalos.splice(i, 1);
			pezM.pararPez();
			this.removeChild(pezM);
			pezM = null;
		}
		
		
		private function CuentaAtras(ti:TimerEvent):void{
			
		    this.contador--;//vamos restandole uno al valor del contador cada vez que pasamos a la funcion que sera cada segundo porque asi lo definimos en el timer y en el addeventlistener
			this.textoContador.text=contador.toString();//hacemos una conversion de contador que es int a tipo string para poder mostrarlo en la caja de texto
			this.addChild(this.textoContador);//con este metodo mostramos el texto en la pantalla
				
				//si el contador llega a cero el contador se para y el jugador pierde
				if (this.contador<=0){
					timerContador.stop();//si el contador llega a cero se detiene
					this.fin=new TextField();
					this.fin.x=50;
					this.fin.y=50;
					
					 this.fin.autoSize = "left";
					this.fin.text="EL CONTADOR HA LLEGADO A CERO\n FIN DE LA PARTIDA!!";
					this.addChild(this.fin);
					this.timerGenerador.stop();//con esto paro el timer generador de peces.
					this.timerGeneradorMalos.stop();
					
					
				}
					
					
				else if(this.contador>=100){
					timerContador.stop();//si el contador llega a cero se detiene
					this.ganar=new TextField();
					this.ganar.x=50;
					this.ganar.y=50;
					
					 this.ganar.autoSize = "left";
					this.ganar.text="ENHORABUENA!! HAS GANADO LA PARTIDA!!";
					this.addChild(this.ganar);
					this.timerGenerador.stop();//con esto paro el timer generador de peces.
					this.timerGeneradorMalos.stop();
				}
					
					
			}
		
		
	}
	
}
