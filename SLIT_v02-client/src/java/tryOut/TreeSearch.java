/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tryOut;

import DTOs.UserDTO;
import beans.UserManagerBeanRemote;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import javax.ejb.EJB;
import main.Main;

/**
 *
 * @author Jons
 */
public class TreeSearch {

    protected static TreeNode searchTree = new TreeNode();

    public static void main(String args[]) {
        List<UserDTO> users = Main.getMyUserManager().getUserList();
        System.out.println(users.get(1).name);
        System.out.println(users.get(5).name);
        for (UserDTO u : users) {
            System.out.println("Trying to insert " + u.name);
            searchTree.insert(u.name, u);
        }

        String searchFor = "a";
        List<UserDTO> userNames = searchTree.getUsers(searchFor);

        System.out.println("All users in this list with " + searchFor);
        for (UserDTO u : userNames) {
            System.out.println(u.name);
        }
        searchTree.printNodes();
    }

    private static class TreeNode {

        protected char value;
        protected ArrayList<TreeNode> nextNodes;
        protected ArrayList<UserDTO> user;

        public TreeNode(char value) {
            this.value = Character.toUpperCase(value);
            nextNodes = new ArrayList<>();
            user = new ArrayList<>();
        }

        /**
         * First node in the Tree has a questionmark. in normal use this would
         * never be called though. You just cant assign a null to a char and to
         * not confuse with other letters I decided to put a ? there :)
         */
        public TreeNode() {
            value = '?';
            nextNodes = new ArrayList<>();
            user = new ArrayList<>();
        }

        public char getValue() {
            return value;
        }

        /**
         * gets a character c and returns the Node with that value.
         *
         * @param c
         * @return
         */
        public TreeNode getNextNode(char c) {
            for (TreeNode n : nextNodes) {
                if (n.getValue() == c) {
                    return n;                     // if node is existing it delegates the insert process to the next node and ends here
                }
            }
            return null;
        }

        public ArrayList<UserDTO> getUsers(String name) {

            
            // the following is kind of tricky. It makes sure that the user return starts when the name is empty. Therefore it goes to the next character node 
            // and searches the all users there but without the first letter. So when the name is empty, that means we are in the last node of what the user searched for.
            // that means we have add all follwoing nodes Userlists.
            if (name != null && !name.isEmpty()) {
                name = name.toUpperCase();                
                return this.getNextNode(name.charAt(0)).getUsers(name.substring(1));
            } else {          

                if (nextNodes.isEmpty()) {
                    return user;
                }
                 
                ArrayList<UserDTO> myUsers = new ArrayList<>();
                myUsers.addAll(user);
                for (TreeNode n : nextNodes) {
                    myUsers.addAll(n.getUsers(null));
                }

                
                return myUsers;
            }
        }

        /**
         * gets name and userId and add it at the right node.
         *
         * @param name
         * @param user
         */
        public void insert(String name, UserDTO user) {
            name=name.toUpperCase();
            if (name != null && !name.isEmpty()) {

                TreeNode n = this.getNextNode(name.charAt(0));
                
                //if next node doesnt exist create it                
                if (n == null) {
                    n = new TreeNode(name.charAt(0));
                    nextNodes.add(n);
                    System.out.println("New node " + n.getValue());
                }                
                
                n.insert(name.substring(1), user); // deletes the first letter of the name                

            } else {
                this.user.add(user);
                System.out.println("Endnode " + value + " reached. Adding new user with id " + user);
            }
            System.out.println("Current node: " + this.getValue());
            this.printNodes();
        }

        public void printNodes() {
            Iterator it = nextNodes.iterator();
            if (it.hasNext()) {
                System.out.print("All next nodes: ");
                for (TreeNode n : nextNodes) {
                    System.out.print(n.getValue() + " ");
                }
                System.out.println();
            } else {
                System.out.println("No next nodes");
            }
        }
    }

}
