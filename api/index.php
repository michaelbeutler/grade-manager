 <?php


    function test($param1)
    {
        echo "Test erfolgreich";
        if (isset($param1)) {
            echo $param1;
        };
    };




    $url = isset($_SERVER['PATH_INFO']) ? explode('/', ltrim($_SERVER['PATH_INFO'], '/')) : [];


    var_dump($url);

    function check_routes($ary0)
    {
        spl_autoload_register(function ($ary0) {
            include 'routes/' . $ary0 . '.php';
        });
    };

if (check_routes($url[0])) {echo "Gefunden";} else {echo "nicht gefunden";};

    if (!function_exists($url[0]) or !check_routes($url[0])) {
        echo "function not found";
        header("HTTP/1.0 404 Not Found");
    } else {

        echo "function  found";
        if (isset($url[0])) {
            $url[0]($url[1]);
        };
    };
echo $globalvar;
    ?>

 <p class="">This is the Index</p>