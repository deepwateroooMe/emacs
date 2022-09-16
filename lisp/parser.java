import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;
import java.util.*;
import java.io.*;
import java.nio.file.Paths;
import java.nio.file.Path;
import java.io.IOException;
import java.io.InputStreamReader;

public class parser {
    public static class Solution {

        private static Map<String, String> m = new HashMap<>(); // map [k,v]: [letter, face-string]
        private String [] type = new String [2];
// 12 faces for use
// hi-yellow     y
// highlight     hi
// hi-aquamarine a
// hi-pink    p
// hi-blue    b
// hi-green   g
// hi-salmon  s
// hi-red-b   rb
// hi-blue-b  bb
// hi-green-b gb
// hi-black-b bkb
// hi-black-hb bhb
        void init() {
            type[0] = "?h ?l "; // l: highlight line
            type[1] = "?h ?r "; // r: highlight expression only
            m.put("y", "return ?h ?i ?- ?y ?e ?l tab return ;;; ");
            m.put("hi","return ?h ?i ?g ?h tab return ;;; ");
            m.put("a", "return ?h ?i ?- ?a ?q ?u tab return ;;; ");
            m.put("p", "return ?h ?i ?- ?p ?i ?n tab return ;;; ");
            m.put("b", "return ?h ?i ?- ?b ?l ?u tab return ;;; ");
            m.put("g", "return ?h ?i ?- ?g ?r ?e tab return ;;; ");
            m.put("s", "return ?h ?i ?- ?s ?a ?l tab return ;;; ");
            m.put("rb", "return ?h ?i ?- ?r ?e ?d ?- tab return ;;; ");
            m.put("bb", "return ?h ?i ?- ?b ?l ?u ?e ?- tab return ;;; ");
            m.put("gb", "return ?h ?i ?- ?g ?r ?e ?e ?n ?- tab return ;;; ");
            m.put("bkb", "return ?h ?i ?- ?b ?l ?a ?c ?k ?- ?b return ;;; ");    // hi-black-b
            m.put("bhb", "return ?h ?i ?- ?b ?l ?a ?c ?k ?- ?h tab return ;;; ");// hi-black-hb
        }
        StringBuilder getFormatedKeyWord(String t) {
            int n = t.length(), idx = 0;
            char [] s = t.toCharArray();
            StringBuilder res = new StringBuilder ();
            for (int i = 0; i < n; i++) {
                res.append('?');
                if (s[i] == '(' || s[i] == ')')
                    res.append('\\');
                res.append(s[i]);
                res.append(' ');
            }
            return res;
        }
        String parseOneLine(String t) {
            int n = t.length(), idx = 0;
            char [] s = t.toCharArray();
            StringBuilder res = new StringBuilder ();
            boolean highlightLine = t.startsWith("l ");
            if (highlightLine) {
                res.append(type[0]);
                idx = 2;
            } else res.append(type[1]);
            while (idx < n && s[idx] != ' ') idx++;
            String face = t.substring(highlightLine ? 2 : 0, idx);
            String word = t.substring(idx+1);
            res.append(getFormatedKeyWord(word));
            res.append(m.get(face));
            res.append(word);
            return res.toString();
        }
    }
    public static void main(String[] args) throws IOException {
        Solution s = new Solution();
        s.init();
        
        Path path = Paths.get("bugKeyWords.txt");
        Scanner scanner = new Scanner(path);
        // String line = scanner.nextLine();
        // int lines = Integer.parseInt(line);
        // String [] ss = new String [lines];
        List<String> ss = new ArrayList<>();
        int cnt = 0, idx = 0;
        while (scanner.hasNextLine())
            ss.add(scanner.nextLine());
        scanner.close();
        for (int i = 0; i < ss.size(); i++) {
            String cur = ss.get(i);
            if (cur.length() == 0 || cur.startsWith("// ")) continue;
            String sb = s.parseOneLine(cur);
            System.out.println(sb);
        }
    }
}
