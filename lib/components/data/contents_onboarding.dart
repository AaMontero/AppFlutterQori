class OnboardingContent {
   String image;
   String text;
   String descripcion;

   OnboardingContent({required this.image, required this.text, required this.descripcion});
}

List <OnboardingContent> contents = [
  OnboardingContent(
      image: "assets/images/inversiones.png",
      text: "INVERSIONES",
      descripcion: "La aplicación procesa la solicitud, proporciona información sobre el estado de la solicitud y, en caso de aprobación, facilita la gestión del préstamo.",
  ),
  OnboardingContent(
      image: "assets/images/creditos.png",
      text: "CREDITOS",
      descripcion: "Permite visualizar el rendimiento de activos, realizar nuevas inversiones y acceder a análisis detallados.",
  ),
  OnboardingContent(
      image: "assets/images/transferencia.png",
      text: "TRANSFERENCIAS",
      descripcion: " La aplicación proporciona funciones intuitivas para gestionar destinatarios, revisar historiales de transacciones y garantizar una experiencia eficiente en la gestión de fondos.",
  ),



];
