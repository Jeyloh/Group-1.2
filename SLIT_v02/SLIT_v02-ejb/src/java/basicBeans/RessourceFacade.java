/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package basicBeans;

import entities.Ressource;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Jons
 */
@Stateless
public class RessourceFacade extends AbstractFacade<Ressource> {

    @PersistenceContext(unitName = "SLIT_v02-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public RessourceFacade() {
        super(Ressource.class);
    }

}
