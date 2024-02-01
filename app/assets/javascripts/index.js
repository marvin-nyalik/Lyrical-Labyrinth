document.addEventListener("DOMContentLoaded", function() {
    const menubar = document.getElementById("menubar");
    const desktopmenu = document.getElementById("desktop-menu");

    menubar.addEventListener("click", (event) => {
    event.stopPropagation();
    desktopmenu.style.display = 'flex';
    desktopmenu.style.zIndex = 5;
    desktopmenu.style.height = '100vh';
    desktopmenu.style.position = 'absolute';
    desktopmenu.style.top = '0';
    desktopmenu.style.left = '0';
    desktopmenu.style.bottom = '0';
    desktopmenu.style.right = '0';
    desktopmenu.style.flexDirection = 'column';
    desktopmenu.style.width = '100%';
    desktopmenu.style.background = 'white';
    document.body.style.overflow = 'hidden';
    })
});


