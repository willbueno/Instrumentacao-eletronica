float vo, vtemp, temp;

void timer_isr()
{
  
  vtemp = analogRead(A15);
  vtemp = ((vtemp * 5/1023)+0.7142857142857143)*1/7.142857142857142;
  temp = vtemp*100;
  
  Serial.print("Temperature: ");
  Serial.print(temp);
  Serial.print("  -  Sensor Voltage: ");
  Serial.println(vtemp);
}

void setup() {
  Serial.begin(38400);
  Timer1.initialize(104); // Inicializa o Timer da interrupção (microsegundos) - timer de 16 bits - define a frequencia de amostragem
  Timer1.attachInterrupt(timer_isr, 104); // Atribui a função teste ao Interrupt
  pinMode(A15, INPUT);
}

void loop() {

}
