import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;
import java.util.List;

public class isPalindrome {
    public static class Solution {

        public boolean isPanlindrome(String s) {
            int i = 0, j = s.length() - 1;
            while (i < j) {
                while (i < j && !Character.isLetterOrDigit(s.charAt(i))) i ++;
                while (i < j && !Character.isLetterOrDigit(s.charAt(j))) j --;
                if (Character.toLowerCase(s.charAt(i)) != Character.toLowerCase(s.charAt(j)))
                return false;
                i++, j--;
            }
            return true;
        }

        public static void main(String[] args) {
            Solution s = new Solution();
        

            System.out.println(res);
        }
        
    }
}