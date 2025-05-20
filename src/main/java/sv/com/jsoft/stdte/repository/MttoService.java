package sv.com.jsoft.stdte.repository;

import org.apache.log4j.Logger;
import sv.com.jsoft.stdte.persistence.*;

import javax.annotation.PostConstruct;
import javax.ejb.Stateless;
import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

import static sv.com.jsoft.stdte.utils.EncryptUtil.encrypt;

@Stateless
public class MttoService {

    protected final static Logger logger = Logger.getLogger(MttoService.class);

    @PersistenceContext
    private EntityManager entityManager;

    @PostConstruct
    public void init() {

    }

    public List<Contribuyentes> findEmisores() {
        List<Contribuyentes> resultado = new ArrayList<>();
        try {
            resultado = entityManager
                    .createQuery("from Contribuyentes c where c.rucTipoContribuyente = 'EMISOR'")
                    .getResultList();
        } catch (Exception e) {

            logger.info("error findEmisores" + e.getMessage());
        }
        return resultado;
    }

    //USUARIOS CRUD OPERATIONS
    public List<Usuarios> retrieveUsers() {
        List<Usuarios> usuariosList = new ArrayList<>();
        try {
            usuariosList = entityManager
                    .createQuery("from Usuarios ").getResultList();
        } catch (Exception e) {

            e.printStackTrace();
            logger.error("error retrieveUsers " + e.getMessage());
        }
        return usuariosList;
    }

    public int saveUser(Usuarios user) {
        int id;
        try {
            if (user.getUsId() == null) {
                user.setUsUsuario(user.getUsUsuario().trim());
                user.setUsClave(encrypt(user.getUsClave()));
                user.setUsuEstado("A");
                user.setUsCorreo(user.getUsCorreo());
                user.setUsUbicacion(user.getUsUbicacion());
                user.setUsPuesto(user.getUsPuesto());
                user.setUsUlbId(user.getUsUlbId());
                user.setUsCortesia(user.getUsCortesia());
                entityManager.persist(user);
                entityManager.flush();
                id = user.getUsId();
            } else {
                Usuarios u = entityManager.find(Usuarios.class, user.getUsId());
                u.setUsuEstado(user.getUsuEstado());
                u.setUsCorreo(user.getUsCorreo());
                u.setUsUbicacion(user.getUsUbicacion());
                u.setUsPuesto(user.getUsPuesto());
                u.setUsUlbId(user.getUsUlbId());
                u.setUsCortesia(user.getUsCortesia());
                entityManager.merge(u);
                id = u.getUsId();
            }
        } catch (Exception e) {
            id = 0;
            e.printStackTrace();
            logger.error("error en createUser " + e.getMessage());

        }
        return id;
    }

    public String deleteUsuario(Usuarios user) {
        String resultado = "OK";
        try {
            Usuarios u = entityManager.find(Usuarios.class, user.getUsId());
            entityManager.remove(u);
        } catch (Exception e) {
            resultado = "FAIL";
        }
        return resultado;
    }

    public List<UbicacionesGeograficas> departamentos() {
        try {
            return entityManager.createQuery("from UbicacionesGeograficas u where u.ugbIddepto = 0").getResultList();
        } catch (Exception e) {
            logger.error("error departamentos " + e.getMessage());
            return null;
        }
    }

    public List<UbicacionesGeograficas> municipios(Integer codDepto) {
        try {
            return entityManager
                    .createQuery("from UbicacionesGeograficas u where u.ugbIddepto = :codDepto and u.ubgCodigo != '00'")
                    .setParameter("codDepto", codDepto)
                    .getResultList();
        } catch (Exception e) {
            logger.error("error municipios " + e.getMessage());
            return null;
        }
    }

    public List<CatalogoCodigoActividadEconomica> actividadEconomicaList() {
        try {
            return entityManager
                    .createQuery("from CatalogoCodigoActividadEconomica ")
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public int saveContribuyente(Contribuyentes contribuyente, String tipoContribuyente) {
        int id;
        try {
            if (contribuyente.getRucId() == null) {
                contribuyente.setRucTipoContribuyente(tipoContribuyente);
                contribuyente.setRucTelefonoPersonal(contribuyente.getRucTelefonoTrabajo());
                contribuyente.setRucNrc((contribuyente.getRucNrc().isEmpty() || contribuyente.getRucNrc().isBlank()) ? null : contribuyente.getRucNrc());
                entityManager.persist(contribuyente);
                entityManager.flush();
                id = contribuyente.getRucId();

            } else {
                Contribuyentes c = entityManager.find(Contribuyentes.class, contribuyente.getRucId());
                c.setRucEmailContribuyente(contribuyente.getRucEmailContribuyente());
                c.setRucNombreRazonsocial(contribuyente.getRucNombreRazonsocial());
                c.setRucNombreComercial(contribuyente.getRucNombreComercial());
                c.setRucTelefonoTrabajo(contribuyente.getRucTelefonoTrabajo());
                c.setRucTelefonoPersonal(contribuyente.getRucTelefonoTrabajo());
                c.setRucCodigoDepartamento(contribuyente.getRucCodigoDepartamento());
                c.setRucCodigoMunicipio(contribuyente.getRucCodigoMunicipio());
                c.setRucDomicilio(contribuyente.getRucDomicilio());
                entityManager.merge(c);
                id = c.getRucId();

            }
        } catch (Exception e) {
            id = 0;
            e.printStackTrace();
            logger.error("error en createUser " + e.getMessage());

        }
        return id;
    }

    public String municipioCode(Contribuyentes cont) {
        String codigoMunicipio;
        try {
            Query query = entityManager
                    .createQuery("from UbicacionesGeograficas u where u.ugbIddepto = :idDepto and ubgCodigo = :codMuni", UbicacionesGeograficas.class);
            query.setParameter("idDepto", Integer.valueOf(cont.getRucCodigoDepartamento())).setParameter("codMuni", cont.getRucCodigoMunicipio());
            UbicacionesGeograficas ubg = (UbicacionesGeograficas) query.getSingleResult();
            codigoMunicipio = ubg.getUbgCodigo();

        } catch (Exception e) {
            logger.error("error municipioCode " + e.getMessage());
            codigoMunicipio = null;
        }
        return codigoMunicipio;
    }

    public List<Contribuyentes> findReceptores() {
        List<Contribuyentes> resultado = new ArrayList<>();
        try {
            resultado = entityManager
                    .createQuery("from Contribuyentes c where c.rucTipoContribuyente = 'RECEPTOR'")
                    .getResultList();

        } catch (Exception e) {
            logger.info("error findReceptores" + e.getMessage());
        }
        return resultado;
    }

    public CatalogoProductos findProductoByCodigo(String codigo) {
        try {
            return (CatalogoProductos) entityManager.createQuery("from CatalogoProductos cp where cp.codigoProd = :codigoProd")
                    .setParameter("codigoProd", codigo)
                    .getResultList()
                    .stream().findFirst().orElse(null);
        } catch (Exception e) {
            logger.error("No se encontro producto con codigo: " + codigo);
            return null;
        }
    }

    public int saveProducto(CatalogoProductos producto) {
        int id = 0;
        try {
            UnidadesMedida um = entityManager.find(UnidadesMedida.class, producto.getUnidadMedida().getUmCodigo());
            producto.setUnidadMedida(um);
            
            if (producto.getIdcatProd() == null) {
                if (producto.getExento()) {
                    producto.setCpExento("S");
                } else {
                    producto.setCpExento("N");
                }

                if (producto.getActivo()) {
                    producto.setCpActivo("S");
                } else {
                    producto.setCpActivo("N");
                }

                entityManager.persist(producto);
                entityManager.flush();
                id = producto.getIdcatProd();
            } else {
                CatalogoProductos cp = entityManager.find(CatalogoProductos.class, producto.getIdcatProd());
                cp.setValorUnitario(producto.getValorUnitario());
                cp.setCpActivo(producto.getCpActivo() != null ? producto.getCpActivo() : "N");
                cp.setCpExento(producto.getCpExento() != null ? producto.getCpExento() : "N");
                //cp.setCpUnidadMedida(producto.getCpUnidadMedida());
                cp.setCpCitId(producto.getCpCitId());
                cp.setCpCodigoBrilo(producto.getCpCodigoBrilo());
                entityManager.merge(cp);
                id = cp.getIdcatProd();
            }
        } catch (Exception e) {
            logger.error("error en saveProducto", e);
        }
        return id;
    }

    public List<CatalogoProductos> findAllProductos() {
        try {
            return entityManager.createQuery("from CatalogoProductos ", CatalogoProductos.class)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();

            return null;
        }
    }

    public String unidadDeMedidaDesc(Integer uniCod) {
        String descripcion;
        try {
            UnidadesMedida u = entityManager
                    .createQuery("from UnidadesMedida u where u.umCodigo = :uniCodigo", UnidadesMedida.class)
                    .setParameter("uniCodigo", uniCod)
                    .getSingleResult();
            descripcion = u.getUmDescripcion();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return descripcion;
    }

    public CatalogoCodigoActividadEconomica findActividadEconomicaByCode(String codigo) {
        try {
            return (CatalogoCodigoActividadEconomica) entityManager.createQuery("from CatalogoCodigoActividadEconomica cae where cae.ccaeCodigo = :codigo")
                    .setParameter("codigo", codigo)
                    .getResultList()
                    .stream().findFirst().orElse(null);
        } catch (Exception e) {
            logger.error("No se encontro actividad con codigo: " + codigo);
            return null;
        }
    }

    public List<CatalogoPuestosUsuarios> retrievePuestosUsers() {
        List<CatalogoPuestosUsuarios> puestosUsersList = new ArrayList<>();
        try {
            puestosUsersList = entityManager
                    .createQuery("from CatalogoPuestosUsuarios ").getResultList();
        } catch (Exception e) {

            e.printStackTrace();
            logger.error("error retrievePuestosUsers " + e.getMessage());
        }
        return puestosUsersList;
    }

    public List<CatalogoOrigenes> retrieveOrigenesUsers() {
        List<CatalogoOrigenes> origenesUsersList = new ArrayList<>();
        try {
            origenesUsersList = entityManager
                    .createQuery("from CatalogoOrigenes ").getResultList();
        } catch (Exception e) {

            e.printStackTrace();
            logger.error("error retrieveOrigenesUsers " + e.getMessage());
        }
        return origenesUsersList;
    }

    public List<UnidadesLaborales> retrieveUniLaboralesUsers() {
        List<UnidadesLaborales> uniLaboralesUsersList = new ArrayList<>();
        try {
            uniLaboralesUsersList = entityManager
                    .createQuery("from UnidadesLaborales ").getResultList();
        } catch (Exception e) {

            e.printStackTrace();
            logger.error("error retrieveUniLaboralesUsers " + e.getMessage());
        }
        return uniLaboralesUsersList;
    }

}
