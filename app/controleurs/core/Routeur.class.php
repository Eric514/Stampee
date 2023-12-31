<?php

/**
 * Classe Routeur
 * analyse l'uri et exécute la méthode associée  
 *
 */

class Routeur
{

  private $routes = [
    // uri, classe, méthode
    // --------------------
    ["admin",            "Admin",       "gererAdmin"],
    ["accueil",          "Frontend",    "afficherAccueil"],
    ["",                 "Frontend",    "afficherAccueil"],
    ["catalogue",        "Frontend",    "afficherCatalogue"],
    ["enchere",          "Frontend",    "afficherEnchere"],
    ["register",         "Frontend",    "afficherRegister"],
    ["login",            "Frontend",    "afficherLogin"],
    ["placerEnchere",    "Frontend",    "afficherPlacerEnchere"],
    ["ajouterEnchere",   "Encheres",    "ajouterEnchere"],
    ["mise",             "Encheres",    "ajouterMise"],
    ["profilMembre",     "Frontend",    "afficherProfilMembre"],
    ["membre",            "Membre",       "gererAdmin"],
    ["rechercherEnchere", "Encheres",       "gererAdmin"],
  
  ];

  protected $oRequetesSQL; // objet RequetesSQL utilisé par tous les contrôleurs

  const BASE_URI = '/stampee/';

  const FORBIDDEN       = 'HTTP 403';
  const ERROR_NOT_FOUND = 'HTTP 404';

  /**
   * Constructeur qui valide l'URI,
   * instancie un contrôleur et exécute une méthode de ce contrôleur,
   * chaque URI valide est associé à un contrôleur et une méthode de ce contrôleur
   */
  public function __construct()
  {
    try {

      // contrôle de l'uri si l'action coïncide
      $uri =  $_SERVER['REQUEST_URI'];
      if (strpos($uri, '?')) $uri = strstr($uri, '?', true);

      foreach ($this->routes as $route) {

        $routeUri     = self::BASE_URI . $route[0];
        $routeClasse  = $route[1];
        $routeMethode = $route[2];

        if ($routeUri ===  $uri) {
          // on exécute la méthode associée à l'uri
          $oControleur = new $routeClasse;
          $oControleur->$routeMethode();
          exit;
        }
      }
      // aucune route ne correspond à l'uri
      throw new Exception(self::ERROR_NOT_FOUND);
    } catch (Error | Exception $e) {
      $this->erreur($e);
    }
  }


  /**
   * Méthode qui envoie un compte-rendu d'erreur
   * @param Exception $e 
   */
  public function erreur($e)
  {
    $message = $e->getMessage();
    if ($message == self::FORBIDDEN) {
      header('HTTP/1.1 403 Forbidden');
    } else if ($message == self::ERROR_NOT_FOUND) {
      header('HTTP/1.1 404 Not Found');
      (new Vue)->generer('vErreur404', [], 'gabarit-erreur');
    } else {
      // header('HTTP/1.1 500 Internal Server Error');
      (new Vue)->generer(
        'vErreur500',
        ['message' => $message, 'fichier' => $e->getFile(), 'ligne' => $e->getLine()],
        'gabarit-erreur'
      );
    }
    exit;
  }
}
