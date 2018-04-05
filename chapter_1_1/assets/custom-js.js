$(window).scroll(function() {
        if ($(".navbar").offset().top > 50) {
            $('.navbar-axy img').attr('src','assets/images/nav_logo_2.png'); //change src
        } else {
            $('.navbar-axy img').attr('src','assets/images/nav_logo_1.png')
        }   
});