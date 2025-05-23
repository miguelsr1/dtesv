package sv.com.jsoft.stdte.repository;

import sv.com.jsoft.stdte.persistence.*;
import javax.ejb.Stateless;
import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
import lombok.extern.slf4j.Slf4j;

@Stateless
@Slf4j
public class MttoService {

    @PersistenceContext
    private EntityManager em;

    public List<Contribuyentes> findEmisores() {
        List<Contribuyentes> resultado = new ArrayList<>();
        try {
            resultado = em
                    .createQuery("from Contribuyentes c where c.rucTipoContribuyente = 'EMISOR'")
                    .getResultList();
        } catch (Exception e) {
            log.error("error findEmisores", e);
        }
        return resultado;
    }

    //USUARIOS CRUD OPERATIONS
    /*public List<Usuario> retrieveUsers() {
        List<Usuario> usuariosList = new ArrayList<>();
        try {
            usuariosList = entityManager
                    .createQuery("from Usuarios ").getResultList();
        } catch (Exception e) {
            log.error("error retrieveUsers ", e);
        }
        return usuariosList;
    }*/

    public String deleteUsuario(Usuario user) {
        String resultado = "OK";
        try {
            Usuario u = em.find(Usuario.class, user.getCorreoElectronico());
            em.remove(u);
        } catch (Exception e) {
            resultado = "FAIL";
        }
        return resultado;
    }

    public List<UbicacionesGeograficas> departamentos() {
        try {
            return em.createQuery("from UbicacionesGeograficas u where u.ugbIddepto = 0").getResultList();
        } catch (Exception e) {
            log.error("error departamentos ", e);
            return null;
        }
    }

    public List<UbicacionesGeograficas> municipios(Integer codDepto) {
        try {
            return em
                    .createQuery("from UbicacionesGeograficas u where u.ugbIddepto = :codDepto and u.ubgCodigo != '00'")
                    .setParameter("codDepto", codDepto)
                    .getResultList();
        } catch (Exception e) {
            log.error("error municipios ", e);
            return null;
        }
    }

    public List<CatalogoCodigoActividadEconomica> actividadEconomicaList() {
        try {
            return em
                    .createQuery("from CatalogoCodigoActividadEconomica ")
                    .getResultList();
        } catch (Exception e) {
            log.error("ERROR EN actividadEconomicaList ", e);
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
                em.persist(contribuyente);
                em.flush();
                id = contribuyente.getRucId();

            } else {
                Contribuyentes c = em.find(Contribuyentes.class, contribuyente.getRucId());
                c.setRucEmailContribuyente(contribuyente.getRucEmailContribuyente());
                c.setRucNombreRazonsocial(contribuyente.getRucNombreRazonsocial());
                c.setRucNombreComercial(contribuyente.getRucNombreComercial());
                c.setRucTelefonoTrabajo(contribuyente.getRucTelefonoTrabajo());
                c.setRucTelefonoPersonal(contribuyente.getRucTelefonoTrabajo());
                c.setRucCodigoDepartamento(contribuyente.getRucCodigoDepartamento());
                c.setRucCodigoMunicipio(contribuyente.getRucCodigoMunicipio());
                c.setRucDomicilio(contribuyente.getRucDomicilio());
                em.merge(c);
                id = c.getRucId();

            }
        } catch (Exception e) {
            id = 0;
            log.error("ERROR EN createUser", e);
        }
        return id;
    }

    public String municipioCode(Empresa emp) {
        String codigoMunicipio;
        try {
            Query query = em.createQuery("select u from UbicacionesGeograficas u where u.ugbIddepto = :idDepto and u.ubgCodigo = :codMuni", UbicacionesGeograficas.class);
            query.setParameter("idDepto", Integer.valueOf(emp.getCodigoDepartamento())).setParameter("codMuni", emp.getCodigoMunicipio());
            UbicacionesGeograficas ubg = (UbicacionesGeograficas) query.getSingleResult();
            codigoMunicipio = ubg.getUbgCodigo();

        } catch (NumberFormatException e) {
            log.error("ERROR EN municipioCode", e);
            codigoMunicipio = null;
        }
        return codigoMunicipio;
    }

    public List<Contribuyentes> findReceptores() {
        List<Contribuyentes> resultado = new ArrayList<>();
        try {
            resultado = em
                    .createQuery("from Contribuyentes c where c.rucTipoContribuyente = 'RECEPTOR'")
                    .getResultList();

        } catch (Exception e) {
            log.error("ERROR EN findReceptores", e);
        }
        return resultado;
    }

    public CatalogoProductos findProductoByCodigo(String codigo) {
        try {
            return (CatalogoProductos) em.createQuery("from CatalogoProductos cp where cp.codigoProd = :codigoProd")
                    .setParameter("codigoProd", codigo)
                    .getResultList()
                    .stream().findFirst().orElse(null);
        } catch (Exception e) {
            log.error("ERROR EN findProductoByCodigo", e);
            return null;
        }
    }

    public int saveProducto(CatalogoProductos producto) {
        int id = 0;
        try {
            UnidadesMedida um = em.find(UnidadesMedida.class, producto.getUnidadMedida().getUmCodigo());
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

                em.persist(producto);
                em.flush();
                id = producto.getIdcatProd();
            } else {
                CatalogoProductos cp = em.find(CatalogoProductos.class, producto.getIdcatProd());
                cp.setValorUnitario(producto.getValorUnitario());
                cp.setCpActivo(producto.getCpActivo() != null ? producto.getCpActivo() : "N");
                cp.setCpExento(producto.getCpExento() != null ? producto.getCpExento() : "N");
                //cp.setCpUnidadMedida(producto.getCpUnidadMedida());
                cp.setCpCitId(producto.getCpCitId());
                cp.setCpCodigoBrilo(producto.getCpCodigoBrilo());
                em.merge(cp);
                id = cp.getIdcatProd();
            }
        } catch (Exception e) {
            log.error("ERROR EN saveProducto", e);
        }
        return id;
    }

    public String unidadDeMedidaDesc(Integer uniCod) {
        String descripcion;
        try {
            UnidadesMedida u = em
                    .createQuery("from UnidadesMedida u where u.umCodigo = :uniCodigo", UnidadesMedida.class)
                    .setParameter("uniCodigo", uniCod)
                    .getSingleResult();
            descripcion = u.getUmDescripcion();
        } catch (Exception e) {
            log.error("ERROR EN unidadDeMedidaDesc", e);
            return null;
        }
        return descripcion;
    }

    public CatalogoCodigoActividadEconomica findActividadEconomicaByCode(String codigo) {
        try {
            return (CatalogoCodigoActividadEconomica) em.createQuery("from CatalogoCodigoActividadEconomica cae where cae.ccaeCodigo = :codigo")
                    .setParameter("codigo", codigo)
                    .getResultList()
                    .stream().findFirst().orElse(null);
        } catch (Exception e) {
            log.error("ERROR EN findActividadEconomicaByCode", e);
            return null;
        }
    }

    public List<CatalogoPuestosUsuarios> retrievePuestosUsers() {
        List<CatalogoPuestosUsuarios> puestosUsersList = new ArrayList<>();
        try {
            puestosUsersList = em
                    .createQuery("from CatalogoPuestosUsuarios ").getResultList();
        } catch (Exception e) {
            log.error("ERROR EN retrievePuestosUsers", e);
        }
        return puestosUsersList;
    }

    public List<CatalogoOrigenes> retrieveOrigenesUsers() {
        List<CatalogoOrigenes> origenesUsersList = new ArrayList<>();
        try {
            origenesUsersList = em
                    .createQuery("from CatalogoOrigenes ").getResultList();
        } catch (Exception e) {
            log.error("ERROR EN retrieveOrigenesUsers", e);
        }
        return origenesUsersList;
    }

    public List<UnidadesLaborales> retrieveUniLaboralesUsers() {
        List<UnidadesLaborales> uniLaboralesUsersList = new ArrayList<>();
        try {
            uniLaboralesUsersList = em
                    .createQuery("from UnidadesLaborales ").getResultList();
        } catch (Exception e) {
            log.error("ERROR EN retrieveUniLaboralesUsers", e);
        }
        return uniLaboralesUsersList;
    }

}
