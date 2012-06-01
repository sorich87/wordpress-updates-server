/*
 * Small set of functions that adds some functionality
 * to javascript prototypes/the site that are re-usable
 */


// "hello world".capitalize() # 'Hello world'
String.prototype.capitalize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
}