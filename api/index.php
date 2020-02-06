 <?php


    function test($param1)
    {
        echo "Test erfolgreich";
        if (isset($param1)) {echo $param1;};
    };




    $url = isset($_SERVER['PATH_INFO']) ? explode('/', ltrim($_SERVER['PATH_INFO'], '/')) : [];

    print_r($url);
    var_dump($url);



    if (function_exists($url[0])) {
        echo "function  found";
        if (isset($url[0])) {
            $url[0]($url[1]);
        };
    } else {
        echo "function not found";
        header("HTTP/1.0 404 Not Found");
    };

    ?>

 <p class="">This is the Index</p>