public class RecursionChecker {
    private static boolean run = true;

    public static boolean runOnce() {
        if (run) {
            run = false;
            return true;
        } else {
            return false;
        }
    }
}
