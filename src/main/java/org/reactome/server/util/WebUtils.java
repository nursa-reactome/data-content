package org.reactome.server.util;

import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Guilherme S Viteri <gviteri@ebi.ac.uk>
 */

public class WebUtils {

    public static String cleanReceivedParameter(String param) {
        if (param != null && !param.isEmpty()) {
            return Jsoup.clean(param, Whitelist.basic());
        }
        return null;
    }

    public static List<String> cleanReceivedParameters(List<String> list) {
        if (list != null && !list.isEmpty()) {
            List<String> checkedList = new ArrayList<>();
            for (String output : list) {
                checkedList.add(cleanReceivedParameter(output));
            }
            return checkedList;
        }
        return null;
    }
}
