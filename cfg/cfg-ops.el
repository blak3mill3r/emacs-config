
(fset 'kube-env-to-bash-export
      [?d ?s ?\{ ?d ?f ?: ?j ?d ?f ?: ?k ?l ?d ?s ?\" ?f ?, ?r ?= ?J ?^ ?i ?e ?x ?p ?o ?r ?t ?  escape ?f ?  ?x ?$ ?x ?^ ?/ ?\{ return])

(use-package kubernetes
  :demand t
  :commands (kubernetes-overview)
  ;; :general
  ;; (:keymaps 'kubernetes-mode-map
  ;;  :states '(normal)
  ;;  "RET" 'kubernetes-navigate)
  )

(use-package kubernetes-evil
  :demand t
  :after kubernetes)
